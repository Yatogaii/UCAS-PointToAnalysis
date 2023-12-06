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
    std::set<Instruction *> LiveVars;             /// Set of variables which are live
    PointToInfo() : LiveVars() {}
    PointToInfo(const PointToInfo & info) : LiveVars(info.LiveVars) {}

    bool operator == (const PointToInfo & info) const {
        return LiveVars == info.LiveVars;
    }
};

inline raw_ostream &operator<<(raw_ostream &out, const PointToInfo &info) {
    for (std::set<Instruction *>::iterator ii=info.LiveVars.begin(), ie=info.LiveVars.end();
         ii != ie; ++ ii) {
        const Instruction * inst = *ii;
        out << inst->getName();
        out << " ";
    }
    return out;
}

class PointToVisitor : public DataflowVisitor<struct PointToInfo> {
public:
    PointToVisitor() {}
    void merge(PointToInfo * dest, const PointToInfo & src) override {
        for (std::set<Instruction *>::const_iterator ii = src.LiveVars.begin(),
                     ie = src.LiveVars.end(); ii != ie; ++ii) {
            dest->LiveVars.insert(*ii);
        }
    }

    void compDFVal(Instruction *inst, PointToInfo * dfval) override{
        // 不处理 LLVM 指令
        if (isa<DbgInfoIntrinsic>(inst)) return;
        LOG_DEBUG("Current instruction: " << *inst);
        dfval->LiveVars.erase(inst);
        for(User::op_iterator oi = inst->op_begin(), oe = inst->op_end();
            oi != oe; ++oi) {
            Value * val = *oi;
            if (isa<Instruction>(val))
                dfval->LiveVars.insert(cast<Instruction>(val));
        }
    }
};

#endif //ASSIGN3_POINT_TO_H
