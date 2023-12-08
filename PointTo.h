#ifndef ASSIGN3_POINT_TO_H
#define ASSIGN3_POINT_TO_H

#include "Dataflow.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"
#include <set>
using namespace llvm;

struct PointToInfo {
    // pointToSets: 一个变量它指向什么
    // binding: 一个变量它等同于什么，可以理解为别名
    std::map<Value *, std::set<Value *>> pointToSets;
    std::map<Value *, std::set<Value *>> bindings; // 存储临时变量绑定关系

    // LiveVars 猜测是可能被指针指向的变量集合
    std::set<Instruction *> LiveVars;             /// Set of variables which are live
    PointToInfo() : LiveVars() {}
    PointToInfo(const PointToInfo & info) : LiveVars(info.LiveVars) {}

    bool operator==(const PointToInfo &pts) const {
        return pointToSets == pts.pointToSets && bindings == pts.bindings;
    }

    bool operator!=(const PointToInfo &pts) const {
        return pointToSets != pts.pointToSets || bindings != pts.bindings;
    }

    // 查看这个值有没有别名
    bool hasBinding(Value* value){
        return bindings.find(value) != bindings.end();
    }

    void setBinding(Value * val, std::set<Value *> binding){
        bindings[val] = binding;
    }

    std::set<Value *> getBinding(Value* val){
        return bindings[val];
    }
};
inline raw_ostream &operator<<(raw_ostream &out,
                               const std::set<Value *> &setOfValues) {
    out << "{";
    for (auto iter = setOfValues.begin(); iter != setOfValues.end(); iter++) {
        if (iter != setOfValues.begin()) {
            out << ", ";
        }
        if ((*iter)->hasName()) {
            if (isa<Function>(*iter)) {
                out << "@" << (*iter)->getName();
            } else {
                out << "%" << (*iter)->getName();
            }
        } else {
            out << "%*";
        }
    }
    out << "}";
    return out;
}
inline raw_ostream &operator<<(raw_ostream &out, const PointToInfo &info) {
    out << "Point-to sets: \n";
    for (const auto& v : info.pointToSets) {
        out << "\t%";
        if (v.first->hasName()) {
            out << v.first->getName();
        } else {
            out << "*"; // 临时变量的数字标号是打印时生成的，无法获取
        }
        out << ": " << v.second << "\n";
    }
    out << "Temp value bindings: \n";
    for (const auto& v : info.bindings) {
        out << "\t%";
        if (v.first->hasName()) {
            out << v.first->getName();
        } else {
            out << "*"; // 临时变量的数字标号是打印时生成的，无法获取
        }
        out << "= " << v.second << "\n";
    }

    return out;
}

class PointToVisitor : public DataflowVisitor<struct PointToInfo> {
public:
    // 存放函数调用结果，输出模式为行号：函数名
    std::map<unsigned , std::set<std::string>> results;

    PointToVisitor() {}

    // 这一部分和基础思路抄的https://github.com/ChinaNuke/Point-to-Analysis
    void merge(PointToInfo *dest, const PointToInfo &src) override {
        // 合并 pointToSets
        auto &destSets = dest->pointToSets;
        const auto &srcSets = src.pointToSets;

        for (const auto &pts : srcSets) {
            Value *k = pts.first;
            const std::set<Value *> &s = pts.second;

            auto result = destSets.find(k);
            if (result == destSets.end()) {
                destSets.insert(std::make_pair(k, s));
            } else {
                result->second.insert(s.begin(), s.end());
            }
        }

        // 合并 bindings
        // 一般情况下绑定信息是不需要在基本块之间传递的，但是为了能够解决引用型参数和函数返回问题，
        // 在这里也进行合并，不影响结果，但是可能会让调试信息更杂乱。
        auto &destBindings = dest->bindings;
        const auto &srcBindings = src.bindings;

        for (const auto &binding : srcBindings) {
            Value *k = binding.first;
            const std::set<Value *> &s = binding.second;

            auto result = destBindings.find(k);
            if (result == destBindings.end()) {
                destBindings.insert(std::make_pair(k, s));
            } else {
                result->second.insert(s.begin(), s.end());
            }
        }
    }


    void handleAllocaInst(AllocaInst *pInst, PointToInfo *pInfo) {
        LOG_DEBUG("Alloca Inst!" << *pInst);
    }

    void handleStoreInst(StoreInst *pInst, PointToInfo *pInfo) {
        LOG_DEBUG("Store Inst!" << *pInst);
        Value *value = pInst->getValueOperand();
        Value *pointer = pInst->getPointerOperand();

        // 忽略常量数据
        // https://llvm.org/doxygen/classllvm_1_1Constant.html
        if (isa<ConstantData>(value)) {
            LOG_DEBUG("Skipped constant data " << *value << " in StoreInst.");
            return;
        }

        // 如果有别名，那么把别名的值也给加入到 PTS 里。
        // 三维地图看世界
        // 注意这里 key 是 pointer，value 是 value
        if(pInfo->hasBinding(pointer)){
            pInfo->pointToSets[pointer].insert(pInfo->bindings[value].begin(), pInfo->bindings[value].end());
        } else { // 否则只加入当前的值
            pInfo->pointToSets[pointer].insert(value);
        }


    }

    void handleLoadInst(LoadInst *pInst, PointToInfo *pInfo) {
        LOG_DEBUG("Load Inst!" << *pInst);
        // 获取 value 以及 pointer
        Value *pointer = pInst->getPointerOperand();
        Value *result = dyn_cast<Value>(pInst);

        // 只处理二级指针及以上，因为一级指针总是指向常数
        // https://stackoverflow.com/a/12954400/15851567
        if (!pointer->getType()->getContainedType(0)->isPointerTy()) {
            return;
        }

        // 获取binding， binding 的值是 pointToSets里的值
        pInfo->setBinding(result, pInfo->pointToSets[pointer]);
    }

    void handleGEPInst(GetElementPtrInst *pInst, PointToInfo *pInfo) {
        LOG_DEBUG("GetElementPtr Inst!" << *pInst);
    }

    void handleCastInst(CastInst *pInst, PointToInfo *pInfo) {
        LOG_DEBUG("Cast Inst!" << *pInst);
    }

    // 由于程序传入的只有 main 函数，所以需要在 call 里面执行具体的函数分析
    void handleCallInst(CallInst *callInst, PointToInfo *pInfo) {
        LOG_DEBUG("Call Inst!" << *callInst);
        LOG_DEBUG("Cuurent stat "<< *pInfo);
        Value *operand = callInst->getCalledOperand();

        // 存放即将要处理的函数列表
        std::set<Value *> funcQueue;
        if(isa<Function>(operand)){
            funcQueue.insert(operand);
        } else {
            funcQueue.insert(pInfo->bindings[operand].begin(), pInfo->bindings[operand].end());
        }

        std::set<std::string>& curLineResult = results[callInst->getDebugLoc().getLine()];

        // 开始处理函数队列
        LOG_DEBUG("funcQueue Size : " << funcQueue.size());
        while(!funcQueue.empty()){
            LOG_DEBUG("Start handle funcQueue");
            // 取出一个函数
            Value* func = *funcQueue.begin();
            funcQueue.erase(func);

            //  存入结果集
            curLineResult.insert(func->getName());

            // TODO:处理函数参数
            for (unsigned i = 0, num = callInst->getNumArgOperands(); i < num; i++) {
                Value* arg = callInst->getArgOperand(i);

                if(!arg->getType()->isPointerTy()){
                    // 不是指针的参数就不考虑
                    continue;
                }

            }

            // TODO:处理函数返回值

        }
    }


    void handlePHINode(PHINode *pNode, PointToInfo *pInfo) {
    }

    void handleSelectInst(SelectInst *pInst, PointToInfo *pInfo) {
    }

    void compDFVal(Instruction *inst, PointToInfo * dfval) override{
        // 不处理 LLVM 指令
        if (isa<DbgInfoIntrinsic>(inst)) return;

        if (AllocaInst *allocaInst = dyn_cast<AllocaInst>(inst)) {
            // 处理Alloca指令，没什么用，只声明不赋值
            handleAllocaInst(allocaInst, dfval);
        } else if (StoreInst *storeInst = dyn_cast<StoreInst>(inst)) {
            // 处理Store指令
            handleStoreInst(storeInst, dfval);
        } else if (LoadInst *loadInst = dyn_cast<LoadInst>(inst)) {
            // 处理Load指令
            handleLoadInst(loadInst, dfval);
        } else if (GetElementPtrInst *gepInst = dyn_cast<GetElementPtrInst>(inst)) {
            // 处理GetElementPtr指令
            handleGEPInst(gepInst, dfval);
        } else if (CastInst *castInst = dyn_cast<CastInst>(inst)) {
            // 处理Cast指令
            handleCastInst(castInst, dfval);
        } else if (CallInst *callInst = dyn_cast<CallInst>(inst)) {
            // 处理函数调用
            handleCallInst(callInst, dfval);
        } else if (PHINode *phiNode = dyn_cast<PHINode>(inst)) {
            // 处理PHI节点
            handlePHINode(phiNode, dfval);
        } else if (SelectInst *selectInst = dyn_cast<SelectInst>(inst)) {
            // 处理Select指令
            handleSelectInst(selectInst, dfval);
        }
    }

    // 打印函数调用结果，输出模式为 'unsigned: string, string'，结果从 results 里面取
    // std::set<unsigned , std::set<std::string>> results;
    void printResults(raw_ostream& ostream) {
        LOG_DEBUG("Start Print Result");
        for (const auto& result : results) {
            const unsigned& key = result.first;
            const std::set<std::string>& values = result.second;

            if (!values.empty()) {
                ostream << key << ": ";
                // 使用迭代器，遍历values里的所有字符串
                for (auto it = values.begin(); it != values.end(); ++it) {
                    // 如果不是第一个字符串，就在前面加上逗号
                    if (it != values.begin())
                        ostream << ", ";
                    ostream << *it;
                }
                ostream << "\n";
            }
        }
    }

};

#endif //ASSIGN3_POINT_TO_H
