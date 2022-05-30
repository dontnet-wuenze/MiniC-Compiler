#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Value.h>
#include <map>
#include <stack>
#include <string>
#include <typeinfo>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/Bitcode/BitcodeWriter.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/MCJIT.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/Support/raw_ostream.h>

#include "treenode.h"

using namespace std;

extern llvm::LLVMContext myContext; //定义全局context
extern llvm::IRBuilder<> myBuilder; //定义全局IRbuilder

class symbolTable{ 
public:
    map<string, llvm::Value*> local_var; //局部变量map
    map<string, llvm::Type*> local_var_type;//局部变量string-llvm::type的map
};


class EmitContext{
public:
    vector<symbolTable *> symbolTable_stack; //符号栈
    stack<llvm::Function*> funStack; //函数栈


public:
    llvm::Module *myModule; 
    llvm::Function *printf,*scanf, *gets;
    llvm::Function* currentFunc;
    llvm::BasicBlock* returnBB;
    llvm::Value* returnVal;
    bool isArgs;
    bool hasReturn;

    EmitContext();
    //~EmitContext();

    map<string, llvm::Value*>& getTop();
    map<string, llvm::Type*>& getTopType();

    void pushBlock();
    void popBlock();

    llvm::Value* findVariable(string variableName);
    llvm::Type* findVariableType(string variableName);

    llvm::Function* getCurFunction();
    void pushFunction(llvm::Function* func);
    void popFunction();

    llvm::Function* getPrintf(); //得到llvm形式的printf函数
    llvm::Function* getScanf();  //得到llvm形式的scanf函数
    llvm::Function* getGets();   //得到llvm形式的gets函数
    void Run(BlockNode* Root);   //对根节点进行run--------------------此处假定parser最开始的根节点为TreeNode

};
