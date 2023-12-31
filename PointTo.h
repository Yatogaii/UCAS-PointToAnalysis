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

    PointToInfo(const PointToInfo &info) {
        //LOG_DEBUG("Trigger copy constructor!");
        pointToSets = info.pointToSets;
        bindings = info.bindings;
    }

    bool operator==(const PointToInfo &pts) const {
        return pointToSets == pts.pointToSets && bindings == pts.bindings;
    }

    bool operator!=(const PointToInfo &pts) const {
        return pointToSets != pts.pointToSets || bindings != pts.bindings;
    }

    // 重载 PointToSet的 = 运算符
    PointToInfo &operator=(const PointToInfo &info) {
        //LOG_DEBUG("Trigger = operator!");
        pointToSets = info.pointToSets;
        bindings = info.bindings;
        return *this;
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

    // 仿照上面has,set,get Binding的实现，对PointToSet实现一样的方法
    bool hasPointToSet(Value* value){
        return pointToSets.find(value) != pointToSets.end();
    }

    void setPointToSet(Value * val, std::set<Value *> pointToSet){
        pointToSets[val] = pointToSet;
    }

    std::set<Value *> getPointToSet(Value* val){
        return pointToSets[val];
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
        //LOG_DEBUG("Alloca Inst!" << *pInst);
    }

    /// DEBUG test00 进入comp嵌套后，第三次storeInst结果出错：
    /// 正常：%a_fptr.addr: {@plus}
    /// 当前：%a_fptr.addr: {%a_fptr}
    /// 错因：pInfo->hasBinding(value)里的参数一定是value，而不是pointer，因为是store的源操作数有binding才需要考虑
    void handleStoreInst(StoreInst *pInst, PointToInfo *pInfo) {
        //LOG_DEBUG("Store Inst!" << *pInst);
        Value *value = pInst->getValueOperand();
        Value *pointer = pInst->getPointerOperand();

        // 忽略常量数据
        // https://llvm.org/doxygen/classllvm_1_1Constant.html
        if (isa<ConstantData>(value)) {
            //LOG_DEBUG("Skipped constant data " << *value << " in StoreInst.");
            return;
        }

        // 如果有别名，那么把别名的值也给加入到 PTS 里。
        // 注意这里 key 是 pointer，value 是 value
        /// *IMPORTANT* 这里的hasBinding的key一定是pointer
        //if(pInfo->hasBinding(pointer)){
//        if(pInfo->hasBinding(value)){
//            pInfo->pointToSets[pointer].insert(pInfo->bindings[value].begin(), pInfo->bindings[value].end());
//        } else { // 否则只加入当前的值
//            pInfo->pointToSets[pointer].insert(value);
//        }

        // test02 需要处理一个指针多个binding的情况。
        std::set<Value *> processSet = {pointer};
        std::set<Value *> pointToSetTargets;
        while(processSet.size() > 0){
            Value *curPointer = *(processSet.begin());
            processSet.erase(curPointer);
            // 如果当前处理的指针有绑定，那么用绑定的值替换实际的值，没有绑定就把当前的这个加入到PTS待处理队列
            if(pInfo->hasBinding(curPointer)){
                processSet.insert(pInfo->bindings[curPointer].begin(), pInfo->bindings[curPointer].end());
            } else {
                pointToSetTargets.insert(curPointer);
            }
        }

        // 同上，开始处理value，看看value有没有binding
        std::set<Value *> values;
        if (pInfo->hasBinding(value)) {
            values = pInfo->getBinding(value);
        } else {
            values.insert(value);
        }

        // 开始处理 pointToSetTargets，更新 pointToSets
        if (pointToSetTargets.size() == 1) {
            pInfo->pointToSets[*pointToSetTargets.begin()] = values;
        } else {
            for (Value *target : pointToSetTargets) {
                std::set<Value *> oldPTS = pInfo->pointToSets[target];
                oldPTS.insert(values.begin(), values.end());
                pInfo->pointToSets[target] = oldPTS;
            }
        }
    }

    void handleLoadInst(LoadInst *pInst, PointToInfo *pInfo) {
        //LOG_DEBUG("Load Inst!" << *pInst);
        // 获取 value 以及 pointer
        Value *pointer = pInst->getPointerOperand();
        Value *result = dyn_cast<Value>(pInst);

        // 只处理二级指针及以上，因为一级指针总是指向常数
        // https://stackoverflow.com/a/12954400/15851567
        if (!pointer->getType()->getContainedType(0)->isPointerTy()) {
            return;
        }

        // 获取binding， binding 的值是 pointToSets里的值
        std::set<Value *> bindings;
        if (pInfo->hasBinding(pointer)) {
            // 如果pointer有绑定，获取所有绑定的目标
            std::set<Value *> boundTargets = pInfo->getBinding(pointer);
            for (Value *boundTarget : boundTargets) {
                // 对每个绑定的目标，获取其点对集并合并
                std::set<Value *> boundPTS = pInfo->pointToSets[boundTarget];
                bindings.insert(boundPTS.begin(), boundPTS.end());
            }
        } else {
            // 如果没有绑定，直接使用原先的getPTS
            bindings = pInfo->pointToSets[pointer];
        }

        pInfo->setBinding(result, bindings);
        LOG_DEBUG("Load Inst Get Result!" << *pInst << " result: " << *result << " binding: " << pInfo->bindings[result]);
    }

    /// DEBUG test02 GEPInst，
    /// getelementptr 指令用于计算复合数据类型（如结构体或数组）内部元素的地址。
    /// 也是处理binding 就行
    void handleGEPInst(GetElementPtrInst *pInst, PointToInfo *pInfo) {
        //LOG_DEBUG("GetElementPtr Inst!" << *pInst);

        Value *ptrval = pInst->getPointerOperand();
        Value *result = dyn_cast<Value>(pInst);

        if (pInfo->hasBinding(ptrval)) {
            pInfo->setBinding(result, pInfo->getBinding(ptrval));
        } else {
            pInfo->setBinding(result, {ptrval});
        }
    }


    void handleCastInst(CastInst *pInst, PointToInfo *pInfo) {
        //LOG_DEBUG("Cast Inst!" << *pInst);
    }

    // 由于程序传入的只有 main 函数，所以需要在 call 里面执行具体的函数分析
    // test00.ll 可以正常获取 24,27 的结果，但是 14 行执行了嵌套调用，无法获取结果，考率 return 为 call 的情况。
    /**
     * @param callInst
     * @param pInfo
     * @思路: 处理普通函数调用的时候直接处理就好，没什么需要额外注意的，需要特殊注意的是返回值为另一个函数调用的嵌套调用情况。
     *      嵌套时需要处理当前的参数 callerArg 以及被调用函数的参数 calleeArg。
     *      callee：被调用函数，call的operand，caller：callInst这个指令，他们的参数是不一样的（形式参数，值传递）。
     *      之后通过手动调用 compForwardVal 来手动传入这些上下文以及 Function 来进行递归调用。
     */
     /// DONE: test00 DEBUG: 在嵌套调用时，第二层在处理funcQueue的时候就会遇到func为Null的情况，与可行的开源答案调试对比了一下，进入handleCall后的第一个
     /// handleStoreInst是比能跑出结果的代码少了一个 bingding的，但是在传入前的时候却是不少的，但是传入后，在嵌套的compForwardDataflow里调用compDFVal
     /// 时，少了一个binding。 错因发现是忘了处理 compForwardDataflow 以支持非空的 result 变量初始化。根本原因是 PointToSets的拷贝构造函数错误。
     /// DEBUG test18
     /// 1. 详细对比每个 basicblock 中的 pTS后发现，是 if 处理后的pts没有正确传递给 else，导致else入口的pts是
     /// 执行 if 之前的，这就导致了 if 基本可以认为没被处理，所以输出缺少 if 对应的那个。
     /// 2. 不对，30行的输出有 clever 和 foo，说明 if 和 else 都被正确处理了，出问题的是 foo 的返回值没有被正确记录。
     /// 3. 发现是递归执行完更新pInfo的 pInfo->setBinding(pair.first, outBinding); 覆盖了原有的binding
     void handleCallInst(CallInst *callInst, PointToInfo *pInfo) {
        //LOG_DEBUG("Call Inst!" << *callInst);
        Value *operand = callInst->getCalledOperand();
        std::set<std::string>& curLineResult = results[callInst->getDebugLoc().getLine()];

        // 对malloc函数调用做特殊处理
        if (isa<Function>(operand) && operand->getName() == "malloc") {
            curLineResult.insert(operand->getName());
            return;
        }

        //

        // 存放即将要处理的函数列表
        std::set<Value *> funcQueue;
        if(isa<Function>(operand)){
            funcQueue.insert(operand);
        } else {
            funcQueue.insert(pInfo->bindings[operand].begin(), pInfo->bindings[operand].end());
        }


        // 开始处理函数队列
        ////LOG_DEBUG("funcQueue Size : " << funcQueue.size());
         // test18: 添加一个map，防止覆盖
         std::set<Value*> isRepeat;
         for(auto* funcVal : funcQueue) {
            Function* func = dyn_cast<Function>(funcVal);

            /// 函数调用准备变量
            // 目标函数入口&出口BB
            BasicBlock *targetEntry = &(func->getEntryBlock());
            BasicBlock *targetExit = &(func->back());
            // 函数调用的初始值，比如一些指针的PointToSet
            PointToInfo calleeArgBindings;
            // 函数调用的参数对比，比如调用者的局部变量对应被调用者的形式参数。
            std::set<std::pair<Value *, Value *>> argPairs;
            // 没用，凑个空
            DataflowResult<PointToInfo>::Type result;
            PointToInfo initval;

            //  存入结果集
            curLineResult.insert(func->getName());

            // TODO:处理函数参数，先不考虑
            for (unsigned i = 0, num = callInst->getNumArgOperands(); i < num; i++) {
                Value* callerArg = callInst->getArgOperand(i);
                Value* calleeArg = func->getArg(i);

                if(!callerArg->getType()->isPointerTy()){
                    // 不是指针的参数就不考虑
                    continue;
                }

                /// 开始处理函数调用前后传递的参数映射
                // 传入的是指针参数，这里的指针参数代表的其实是binding，比如值传递
                argPairs.insert(std::make_pair(callerArg, calleeArg));
                // 如果这个参数传递前已有binding，则直接拿来用
                // 注意是传递前，所以是 callerArg
                std::set<Value *> curCalleeBinding;
                if (pInfo->hasBinding(callerArg)) {
                    curCalleeBinding = pInfo->getBinding(callerArg);
                    ////LOG_DEBUG("CalleeArg Has Binding!" << curCalleeBinding);
                } else { // 如果没有 binding，就把被传的变量作为binding
                    curCalleeBinding = {callerArg};
                    //LOG_DEBUG("CallerArg Binding" << *callerArg);
                }
                calleeArgBindings.setBinding(calleeArg, curCalleeBinding);
                // 开始处理各个binding的pointToSet，方便过一会递归调用的初始状态
                while (!curCalleeBinding.empty()) {
                    Value *curBinding = *curCalleeBinding.begin();
                    curCalleeBinding.erase(curCalleeBinding.begin());
                    // //LOG_DEBUG("Finding dependency for " << *v);
                    if (pInfo->hasPointToSet(curBinding)) {
                        std::set<Value *> curPointToSet = pInfo->getPointToSet(curBinding);
                        //LOG_DEBUG("Dependencies found: " << curPointToSet);
                        calleeArgBindings.setPointToSet(curBinding, curPointToSet);
                        argPairs.insert(std::make_pair(curBinding, curBinding));
                        // 为处理列表里添加新的需要处理的元素
                        curCalleeBinding.insert(curPointToSet.begin(), curPointToSet.end());
                    }
                }
            }

            // 如果返回值类型是函数指针，则进一步处理
            if(func->getReturnType()->isPointerTy()){
                // 这里需要特殊处理一下 initval，因为递归调用的时候已经是有状态的了
                // 直接调用无法保留状态
                //LOG_DEBUG("Function " << func->getName() << " has a pointer return type.");
                calleeArgBindings.setBinding(func, {func});
                argPairs.insert(std::make_pair(dyn_cast<Value>(callInst), func));
            }

            // for test18
            for(auto& each : argPairs){
                isRepeat.insert(each.first);
            }

            // 处理被 call 的函数，直接使用 compForwardDataflow 来处理
            result[targetEntry].first = calleeArgBindings; // incomings of target entry
            //LOG_DEBUG("---------------------------------- Now recursively handling function: " << func->getName() << "----------------------------------");
            compForwardDataflow(func, this, &result, initval);
            PointToInfo &calleeOutBindings = result[targetExit].second; // outcomings of target exit

            LOG_DEBUG("处理完毕函数 " << func->getName() << "，前的PTS \n" << *pInfo);
            // 开始比较处理前后的PointToSets变化，索引为 argPairs
            for (auto &pair : argPairs) {
                if (calleeOutBindings.hasBinding(pair.second)) {
                    const std::set<Value *> &outBinding = calleeOutBindings.getBinding(pair.second);
                    LOG_DEBUG("处理函数 " << func->getName() << "后，" << *pair.first << "的binding变化前," << pInfo->getBinding(pair.first));
                    if(isRepeat.find(pair.first) != isRepeat.end() && pInfo->getBinding(pair.first).size()!=0){
                        auto curBinding = pInfo->getBinding(pair.first);
                        for(auto* each : outBinding)
                            curBinding.insert(each);
                        LOG_DEBUG("CurBinding " << curBinding);
                        pInfo->setBinding(pair.first, curBinding);
                    } else {
                        pInfo->setBinding(pair.first, outBinding);
                    }
                    LOG_DEBUG("处理函数 " << func->getName() << "后，" << *pair.first << "的binding变化后," << pInfo->getBinding(pair.first));
                }

                std::set<Value *> queue = {pair.second};
                while (!queue.empty()) {
                    Value *v = *queue.begin();
                    queue.erase(v);

                    if (calleeOutBindings.hasPointToSet(v)) {
                        std::set<Value *> s = calleeOutBindings.getPointToSet(v);
                        pInfo->setPointToSet(v, s);
                        queue.insert(s.begin(), s.end());
                    }
                }
            }
            LOG_DEBUG("处理完毕函数 " << func->getName() << "，后的PTS \n" << *pInfo);
        }
    }


    void handleReturnInst(ReturnInst* returnInst, PointToInfo *pInfo) {
        Value *value = returnInst->getReturnValue();
        Value *func = returnInst->getFunction();

        //LOG_DEBUG("Return Inst ! " << *returnInst);

        if (pInfo->hasBinding(func)) {
            // 把返回值直接绑定到所在函数上
            if (pInfo->hasBinding(value)) {
                pInfo->setBinding(func, pInfo->getBinding(value));
            } else {
                pInfo->setBinding(func, {value});
            }
        }
    }

    void handlePHINode(PHINode *pNode, PointToInfo *pInfo) {
        //LOG_DEBUG("handle PHINode!" << *pNode);
    }

    void handleSelectInst(SelectInst *pInst, PointToInfo *pInfo) {
        //LOG_DEBUG("handle select!" << *pInst);

    }

    // MemcpyInst 就是复制一个指针的内存到另外一个，考虑直接复制PTS，binding应该不用
    void handleMemcpyInst(MemCpyInst *pInst, PointToInfo *pInfo) {
        auto* left = pInst->getSource();
        auto* right = pInst->getDest();

        // 复制PTS
        pInfo->pointToSets[right] = pInfo->pointToSets[left];
    }

    void compDFVal(Instruction *inst, PointToInfo * pInfo) override{
        LOG_DEBUG("Current Instruction: " << *inst);

        // 不处理 LLVM 指令
        if (isa<DbgInfoIntrinsic>(inst)) return;

        if (AllocaInst *allocaInst = dyn_cast<AllocaInst>(inst)) {
            // 处理Alloca指令，没什么用，只声明不赋值
            handleAllocaInst(allocaInst, pInfo);
        } else if (StoreInst *storeInst = dyn_cast<StoreInst>(inst)) {
            // 处理Store指令
            handleStoreInst(storeInst, pInfo);
        } else if (LoadInst *loadInst = dyn_cast<LoadInst>(inst)) {
            // 处理Load指令
            handleLoadInst(loadInst, pInfo);
        } else if (GetElementPtrInst *gepInst = dyn_cast<GetElementPtrInst>(inst)) {
            // 处理GetElementPtr指令
            handleGEPInst(gepInst, pInfo);
        } else if (CastInst *castInst = dyn_cast<CastInst>(inst)) {
            // 处理Cast指令
            handleCastInst(castInst, pInfo);
        } else if (MemSetInst *memSetInst = dyn_cast<MemSetInst>(inst)) {
            // 捕获但不需要处理，防止它被后面CallInst的处理逻辑捕获
            // 比如这样的：call void @llvm.memset.p0i8.i64(i8* align 8 %0, i8 0, i64 8, i1 false), !dbg !26
        } else if (MemCpyInst* memCpyInst = dyn_cast<MemCpyInst>(inst)){
            handleMemcpyInst(memCpyInst, pInfo);
        }else if (CallInst *callInst = dyn_cast<CallInst>(inst)) {
            // 处理函数调用
            handleCallInst(callInst, pInfo);
        } else if (PHINode *phiNode = dyn_cast<PHINode>(inst)) {
            // 处理PHI节点
            handlePHINode(phiNode, pInfo);
        } else if (SelectInst *selectInst = dyn_cast<SelectInst>(inst)) {
            // 处理Select指令
            handleSelectInst(selectInst, pInfo);
        } else if (ReturnInst *returnInst = dyn_cast<ReturnInst>(inst)) {
            handleReturnInst(returnInst, pInfo);
        } else {
                //LOG_DEBUG("handle UNKNOWN instruction!" << *inst);
        }

    }

    // 打印函数调用结果，输出模式为 'unsigned: string, string'，结果从 results 里面取
    // std::set<unsigned , std::set<std::string>> results;
    void printResults(raw_ostream& ostream) {
        //LOG_DEBUG("Start Print Result");
        for (const auto& result : results) {
            const unsigned& key = result.first;
            const std::set<std::string>& values = result.second;

            if (!values.empty()) {
                ostream << key << " : ";
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
