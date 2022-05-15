#include <llvm-10/llvm/IR/BasicBlock.h>
#include <llvm-10/llvm/IR/Value.h>
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

static llvm::LLVMContext myContext; //定义全局context
static llvm::IRBuilder<> myBuilder(myContext); //定义全局IRbuilder

class basic_block{ 
public:
    llvm::BasicBlock *block;
    llvm::Value* return_value;
    map<string, llvm::Value*> local_var; //局部变量map
};


class EmitContext{
    stack<basic_block *> block_stack; //llvm::block栈


public:
    llvm::Module *myModule; 
    llvm::Function *printf,*scanf;

    EmitContext();
    //~EmitContext();

    map<string, llvm::Value*>& getTop() { 
        return block_stack.top()-> local_var; 
        }
    
    llvm::BasicBlock *getCurrentBlock(){
        return block_stack.top()->block;
    }

    void pushBlock(llvm::BasicBlock *block){
        block_stack.push(new basic_block());
        block_stack.top()->return_value = NULL;
        block_stack.top()->block = block;
    }

    void popBlock(){
        basic_block *tmp = block_stack.top();
        block_stack.pop();
        delete tmp;
    }

    llvm::Value* getReturnValue(){
        return block_stack.top()->return_value;
    }

    void setReturnValue(llvm::Value* value){
        block_stack.top()->return_value = value;
    }

    llvm::Function* getPrintf(); //得到llvm形式的printf函数
    llvm::Function* getScanf(); //得到llvm形式的scanf函数
    void Run(TreeNode* Root); //对根节点进行run--------------------此处假定parser最开始的根节点为TreeNode

};
