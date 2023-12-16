/************************************************************************
 *
 * @file Dataflow.h
 *
 * General dataflow framework
 *
 ***********************************************************************/

#ifndef _DATAFLOW_H_
#define _DATAFLOW_H_

#include <llvm/Support/raw_ostream.h>
#include <map>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/CFG.h>
#include <llvm/IR/Function.h>

//#define GDEBUG

#ifdef GDEBUG
#define LOG_DEBUG(msg)                                                         \
  do {                                                                         \
    errs() << "\u001b[33m[DEBUG] \u001b[0m" << msg << "\n";                    \
  } while (0)
#else
#define LOG_DEBUG(msg)                                                         \
  do {                                                                         \
  } while (0)
#endif

using namespace llvm;

///Base dataflow visitor class, defines the dataflow function

template <class T>
class DataflowVisitor {
public:
    virtual ~DataflowVisitor() { }

    /// Dataflow Function invoked for each basic block 
    /// 
    /// @block the Basic Block
    /// @dfval the input dataflow value
    /// @isforward true to compute dfval forward, otherwise backward
    virtual void compDFVal(BasicBlock *block, T *dfval, bool isforward) {
        if (isforward == true) {
           for (BasicBlock::iterator ii=block->begin(), ie=block->end(); 
                ii!=ie; ++ii) {
                Instruction * inst = &*ii;
                compDFVal(inst, dfval);
           }
        } else {
           for (BasicBlock::reverse_iterator ii=block->rbegin(), ie=block->rend();
                ii != ie; ++ii) {
                Instruction * inst = &*ii;
                compDFVal(inst, dfval);
           }
        }
    }

    ///
    /// Dataflow Function invoked for each instruction
    ///
    /// @inst the Instruction
    /// @dfval the input dataflow value
    /// @return true if dfval changed
    virtual void compDFVal(Instruction *inst, T *dfval ) = 0;

    ///
    /// Merge of two dfvals, dest will be ther merged result
    /// @return true if dest changed
    ///
    virtual void merge( T *dest, const T &src ) = 0;
};

///
/// Dummy class to provide a typedef for the detailed result set
/// For each basicblock, we compute its input dataflow val and its output dataflow val
///
template<class T>
struct DataflowResult {
    typedef typename std::map<BasicBlock *, std::pair<T, T> > Type;
};

///
/// Compute a forward iterated fixedpoint dataflow function, using a user-supplied
/// visitor function. Note that the caller must ensure that the function is
/// in fact a monotone function, as otherwise the fixedpoint may not terminate.
///
/// @param fn The function
/// @param visitor A function to compute dataflow vals
/// @param result The results of the dataflow
/// @initval the Initial dataflow value
/// 根据已有的compBackwardDataflow补充Forward的实现
template<class T>
void compForwardDataflow(Function *fn,
                         DataflowVisitor<T> *visitor,
                         typename DataflowResult<T>::Type *result, //std::map<BasicBlock *, std::pair<T, T> > Type;
                         const T & initval) {

    std::set<BasicBlock *> worklist;

    // Initialize the worklist with all entry blocks
    for (Function::iterator bi = fn->begin(); bi != fn->end(); ++bi) {
        BasicBlock * bb = &*bi;
        // result : map[BasicBlock] = pair(initval, initval);
        // result->insert(std::make_pair(bb, std::make_pair(initval, initval)));
        // 允许传入非空的result值以初始化
        if (result->find(bb) != result->end()) {
            result->insert(std::make_pair(bb, std::make_pair(initval, initval)));
        }
        worklist.insert(bb);
    }

    // Iteratively compute the dataflow result
    while (!worklist.empty()) {
        BasicBlock *bb = *worklist.begin();
        worklist.erase(worklist.begin());

        // Merge all incoming value
        T bbentryval = (*result)[bb].first;
        for (pred_iterator pi = pred_begin(bb), pe = pred_end(bb); pi != pe; ++pi) {
            BasicBlock *pred = *pi;
            visitor->merge(&bbentryval, (*result)[pred].second);
        }

        /// DONE DEBUG test00 即使上面加了允许传入非空值允许result初始化，这个仍然会少一个binding。
        /// 发现是下面这一行的来回赋值把binding值弄没了，应该是没有正常实现这个=的重载。
        /// 实际是没有正确编写拷贝构造函数
        (*result)[bb].first = bbentryval;
        LOG_DEBUG("Start Handling Basic block " << bb->getName());
        visitor->compDFVal(bb, &bbentryval, true);
        (*result)[bb].second = bbentryval;

        LOG_DEBUG("Basic block " << bb->getName() << " in function " << bb->getParent()->getName() << " finished. ");
        LOG_DEBUG("Incoming values: \n" << (*result)[bb].first);
        LOG_DEBUG("Outcoming values(BBEntryval): \n" << (*result)[bb].second);

        // If outgoing value changed, propagate it along the CFG
        if (bbentryval == (*result)[bb].first) continue;

        // DEBUG test02 这里没有正确添加上 Basic block if.end6 导致没有结果产出
        // 不对，已经正常 handle if.end6 了，但是为什么没有到 BasicBlock end 哪里呢
        for (succ_iterator si = succ_begin(bb), se = succ_end(bb); si != se; ++si) {
            worklist.insert(*si);
        }

    }
}

/// 
/// Compute a backward iterated fixedpoint dataflow function, using a user-supplied
/// visitor function. Note that the caller must ensure that the function is
/// in fact a monotone function, as otherwise the fixedpoint may not terminate.
/// 
/// @param fn The function
/// @param visitor A function to compute dataflow vals
/// @param result The results of the dataflow 
/// @initval The initial dataflow value
template<class T>
void compBackwardDataflow(Function *fn,
    DataflowVisitor<T> *visitor,
    typename DataflowResult<T>::Type *result,
    const T &initval) {

    std::set<BasicBlock *> worklist;

    // Initialize the worklist with all exit blocks
    for (Function::iterator bi = fn->begin(); bi != fn->end(); ++bi) {
        BasicBlock * bb = &*bi;
        // result : map[BasicBlock] = pair(initval, initval);
        result->insert(std::make_pair(bb, std::make_pair(initval, initval)));
        worklist.insert(bb);
    }

    // Iteratively compute the dataflow result
    while (!worklist.empty()) {
        BasicBlock *bb = *worklist.begin();
        worklist.erase(worklist.begin());

        // Merge all incoming value
        T bbexitval = (*result)[bb].second;
        // succ_iterator 是一个迭代器，用于遍历一个基本块的所有后继基本块
        for (auto si = succ_begin(bb), se = succ_end(bb); si != se; si++) {
            BasicBlock *succ = *si;
            // 在这个 compBackwardDataflow 函数中，merge 的作用是将所有后继基本块的入口数据流值合并到当前基本块的出口数据流值中。
            //在迭代数据流分析中，每个基本块的数据流值是由其所有后继基本块的数据流值通过一个合并函数（这里的 merge）计算得出的。这个过程会不断重复，直到结果稳定为止。
            visitor->merge(&bbexitval, (*result)[succ].first);
        }

        (*result)[bb].second = bbexitval;
        // 计算当前基本块的出口数据流值。
        visitor->compDFVal(bb, &bbexitval, false);

        // If outgoing value changed, propagate it along the CFG
        if (bbexitval == (*result)[bb].first) continue;
        (*result)[bb].first = bbexitval;

        for (pred_iterator pi = pred_begin(bb), pe = pred_end(bb); pi != pe; pi++) {
            worklist.insert(*pi);
        }
    }
    LOG_DEBUG("end of compBackwardDataflow\n");
}

template<class T>
void printDataflowResult(raw_ostream &out,
                         const typename DataflowResult<T>::Type &dfresult) {
    for ( typename DataflowResult<T>::Type::const_iterator it = dfresult.begin();
            it != dfresult.end(); ++it ) {
        if (it->first == NULL) out << "*";
        else it->first->dump();
        out << "\n\tin : "
            << it->second.first 
            << "\n\tout :  "
            << it->second.second
            << "\n";
    }
}







#endif /* !_DATAFLOW_H_ */
