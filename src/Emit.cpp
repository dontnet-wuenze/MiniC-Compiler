#include <llvm/ADT/Twine.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>
#include <llvm/Support/raw_ostream.h>
#include <vector>
#include "Emit.h"

llvm::LLVMContext myContext; //定义全局context
llvm::IRBuilder<> myBuilder(myContext); //定义全局IRbuilder

llvm::Function* EmitContext::getPrintf(){
    vector<llvm::Type*> printf_arg_types; //printf内参数的类型
    printf_arg_types.push_back(myBuilder.getInt8PtrTy()); //8位代表void*

    llvm::FunctionType* printf_type = 
        llvm::FunctionType::get(myBuilder.getInt32Ty(),printf_arg_types,true);
    llvm::Function* printf_func = 
        llvm::Function::Create(printf_type,llvm::Function::ExternalLinkage,llvm::Twine("printf"),this->myModule);

    printf_func->setCallingConv(llvm::CallingConv::C);
    return printf_func;
}

llvm::Function* EmitContext::getScanf(){
    llvm::FunctionType* scanf_type = 
        llvm::FunctionType::get(myBuilder.getInt32Ty(),true);
    llvm::Function* scanf_func = 
        llvm::Function::Create(scanf_type,llvm::Function::ExternalLinkage,llvm::Twine("scanf"),this->myModule);

    scanf_func->setCallingConv(llvm::CallingConv::C);
    return scanf_func;
}

llvm::Function* EmitContext:: getCurFunction(){
    return funStack.top();
}

void EmitContext::pushFunction(llvm::Function* func){
    funStack.push(func);
}

void EmitContext::popFunction(){
    funStack.pop();
}

void EmitContext::Run(BlockNode* Root){
    Root->emitter(*this);
    llvm::verifyModule(*this->myModule, &llvm::outs());
    this->myModule->print(llvm::outs(), nullptr);
}

EmitContext::EmitContext(){
    this->myModule = new llvm::Module("main",myContext);
    this->printf = getPrintf();
    this->scanf = getScanf();
}

