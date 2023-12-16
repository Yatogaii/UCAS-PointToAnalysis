//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#include <llvm/Support/CommandLine.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Support/ToolOutputFile.h>

#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/Bitcode/BitcodeWriter.h>


#include <llvm/Transforms/Utils.h>
#include <llvm/Transforms/Scalar.h>

#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include <llvm/Support/raw_ostream.h>

#include <iostream>

#include "Liveness.h"
#include "Dataflow.h"
#include "PointTo.h"


using namespace llvm;
static ManagedStatic<LLVMContext> GlobalContext;
static LLVMContext &getGlobalContext() { return *GlobalContext; }

struct EnableFunctionOptPass : public FunctionPass {
    static char ID;
    EnableFunctionOptPass() :FunctionPass(ID) {}
    bool runOnFunction(Function & F) override {
        if (F.hasFnAttribute(Attribute::OptimizeNone))
        {
            F.removeFnAttr(Attribute::OptimizeNone);
        }
        return true;
    }
};

char EnableFunctionOptPass::ID = 0;

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 3
//    x := &y: 这是一个取地址操作，对应于 LLVM IR 中的 alloca 指令，用于在栈上分配内存，并返回一个指向该内存的指针。如果 y 是一个变量，这个操作可能涉及到 load 指令，用于加载 y 的值。
//    x := y: 这是一个赋值操作，在 LLVM IR 中，这通常对应于 store 指令，用于将值 y 存储到变量 x 指向的位置。如果 x 和 y 都是简单的变量（非指针类型），这将是一个简单的 store。
//    *x = y: 这是一个间接赋值操作，在 LLVM IR 中，这也使用 store 指令，但这里 x 是一个指针，y 的值被存储在 x 指向的位置。
//    y = *x: 这是一个间接读取操作，在 LLVM IR 中，这对应于 load 指令，用于从 x 指向的内存位置读取值，并将其存储在 y 中。
//总结一下：
//    x := &y 可能涉及 alloca 和 load 指令。
//    x := y 对应于 store 指令。
//    *x = y 也是 store 指令，但用于间接赋值。
//    y = *x 对应于 load 指令。
// !其他语句对指针集无影响

struct FuncPtrPass : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    FuncPtrPass() : ModulePass(ID) {}

    // 首先根据简单约束条件完成初始约束图和worklist的创建，然后根据复杂约束遍历worklist来添加pts元素，最后得到所有可能的指针指向
    /// 2023-12-16 还有 28 30 31 33 34
    bool runOnModule(Module &M) override {
        PointToVisitor visitor;
        DataflowResult<PointToInfo>::Type result;
        PointToInfo initval;

        //  找到这个Module里面的最后一个定义的函数（在c文件里的最后一个）
        auto f = M.rbegin(), e = M.rend();
        while ((f->isIntrinsic() || f->size() == 0) && f != e)  {
            f++;
        }

        LOG_DEBUG("Entry function: " << f->getName());
        compForwardDataflow(&*f, &visitor, &result, initval);

        // printDataflowResult<PointToInfo>(errs(), result);
        visitor.printResults(errs());
        return false;
    }
};


char FuncPtrPass::ID = 0;
static RegisterPass<FuncPtrPass> X("funcptrpass", "Print function call instruction");

char Liveness::ID = 0;
static RegisterPass<Liveness> Y("liveness", "Liveness Dataflow Analysis");

static cl::opt<std::string>
InputFilename(cl::Positional,
              cl::desc("<filename>.bc"),
              cl::init(""));


int main(int argc, char **argv) {
    LLVMContext &Context = getGlobalContext();
    SMDiagnostic Err;
    // Parse the command line to read the Inputfilename
    std::string s("/root/assign3/bc/test");
    const char* c[2];
    if (argc == 1) {
        std::string t;
        std::cout << "请输入测试编号：";
        std::cin >> t;
        s.append(t).append(".bc");
        c[1] = s.c_str();
        // Parse the command line to read the Inputfilename
        cl::ParseCommandLineOptions(2, c,
                                    "FuncPtrPass \n My first LLVM too which does not do much.\n");
    } else {
    cl::ParseCommandLineOptions(argc, argv,
                                "FuncPtrPass \n My first LLVM too which does not do much.\n");
    }

   // Load the input module
   std::unique_ptr<Module> M = parseIRFile(InputFilename, Err, Context);
   if (!M) {
      Err.print(argv[0], errs());
      return 1;
   }

   llvm::legacy::PassManager Passes;
#if LLVM_VERSION_MAJOR == 5
   Passes.add(new EnableFunctionOptPass());
#endif
   ///Transform it to SSA
   Passes.add(llvm::createPromoteMemoryToRegisterPass());

   /// Your pass to print Function and Call Instructions
   Passes.add(new FuncPtrPass());
   //Passes.add(new FuncPtrPass());
   Passes.run(*M.get());
#ifndef NDEBUG

#endif
}

