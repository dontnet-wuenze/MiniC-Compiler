#include "treenode.h"
#include "Emit.h"
#include <llvm-10/llvm/ADT/ArrayRef.h>
#include <llvm-10/llvm/IR/Constants.h>
#include <llvm-10/llvm/IR/Function.h>
#include <llvm-10/llvm/IR/Instructions.h>
#include <llvm-10/llvm/IR/Type.h>
#include <llvm-10/llvm/IR/Value.h>

using namespace std;


llvm::Value* IntNode::emitter(EmitContext &emitContext){
    cout << "IntNode : " << value <<endl;
    return llvm::ConstantInt::get(llvm::Type::getInt64Ty(myContext),value,true);
}

llvm::Value* DoubleNode::emitter(EmitContext &emitContext){
    cout << "DoubleNode : " << value <<endl;
    return llvm::ConstantFP::get(llvm::Type::getDoubleTy(myContext),value);
}

llvm::Value* CharNode::emitter(EmitContext &emitContext){  //----------  -_-
    cout << "CharNode : " << value <<endl;
    return myBuilder.getInt8(this->value);
}

llvm::Value* IdentifierNode::emitter(EmitContext &emitContext){
    cout << "IdentifierNode : " << name << endl;
    if(emitContext.getTop().find(name) == emitContext.getTop().end){
        std::cerr << "undeclared variable " << name << endl;
        return NULL;
    }
    return new llvm::LoadInst(emitContext.getTop()[name], "", false, emitContext.getCurrentBlock());
}

llvm::Value* IntArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
llvm::Value* DoubleArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
llvm::Value* CharArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-

llvm::Value* FunctionCallNode::emitter(EmitContext &emitContext){
    //在module中查找以identifier命名的函数
    llvm::Function *func = emitContext.myModule->getFunction(identifier.name.c_str());
    if (func == NULL) {
		std::cerr << "no such function " << identifier.name << endl;
	}

    vector<llvm::Value*> tmp;
    vector<ExpressionNode*>::iterator i;
    for(auto i : args){  //对每个ExpressionNode进行emit 并将结果存入tmp中
        tmp.push_back((*i).emitter(emitContext));
    }
    //调用
    llvm::CallInst *call = llvm::CallInst::Create(func,llvm::makeArrayRef(tmp),"",emitContext.getCurrentBlock());
    cout << "Creating method call: " << identifier.name << endl;
	return call;

}

