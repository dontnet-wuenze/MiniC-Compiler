#include "treenode.h"
#include "parsing.hpp"
#include "Emit.h"
#include <llvm/ADT/ArrayRef.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Value.h>
#include <string>
#include <vector>

using namespace std;

stack<llvm::BasicBlock *> GlobalAfterBB;

//辅助函数

llvm::Type* getLLvmType(string type){ //通过type，返回对应的LLVM的Type
    if(type == "int"){return llvm::Type::getInt32Ty(myContext);}
    else if(type == "float"){return llvm::Type::getFloatTy(myContext);}
    else if(type == "char"){return llvm::Type::getInt8Ty(myContext);}
    return llvm::Type::getVoidTy(myContext);
}

llvm::Type* getArrayLLvmType(string type,int size){ //对于数组形式，返回对应的LLVM的Type
    if(type == "int"){ //int数组
        return llvm::ArrayType::get(llvm::Type::getInt32Ty(myContext), size);
    }
    else if(type == "float"){
        return llvm::ArrayType::get(llvm::Type::getFloatTy(myContext), size);
    }
    else if(type == "char"){
        return llvm::ArrayType::get(llvm::Type::getInt8Ty(myContext), size);
    }
    else{return NULL;}
}

llvm::Instruction::CastOps getCastInst(llvm::Type* src, llvm::Type* dst) {
    if (src == llvm::Type::getFloatTy(myContext) && dst == llvm::Type::getInt32Ty(myContext)) { //llvm下float到int
        return llvm::Instruction::FPToSI;  
    }
    else if (src == llvm::Type::getInt32Ty(myContext) && dst == llvm::Type::getFloatTy(myContext)) { //llvm下int到float
        return llvm::Instruction::SIToFP;
    }
    else if (src == llvm::Type::getInt8Ty(myContext) && dst == llvm::Type::getFloatTy(myContext)) {
        return llvm::Instruction::UIToFP;
    }
    else if (src == llvm::Type::getInt8Ty(myContext) && dst == llvm::Type::getInt32Ty(myContext)) {
        return llvm::Instruction::ZExt;
    }
    else if (src == llvm::Type::getInt32Ty(myContext) && dst == llvm::Type::getInt8Ty(myContext)) {
        return llvm::Instruction::Trunc;
    }
    else {
        throw logic_error("[ERROR] Wrong typecast");
    }
}

llvm::Value* typeCast(llvm::Value* src, llvm::Type* dst) {
    llvm::Instruction::CastOps op = getCastInst(src->getType(), dst);
    return myBuilder.CreateCast(op, src, dst, "tmptypecast");
}

llvm::AllocaInst *CreateEntryBlockAlloca(llvm::Function *TheFunction, llvm::StringRef VarName, llvm::Type* type) {
  llvm::IRBuilder<> TmpB(&TheFunction->getEntryBlock(), TheFunction->getEntryBlock().begin());
  return TmpB.CreateAlloca(type, nullptr, VarName);
}

//emitter函数

llvm::Value* IntNode::emitter(EmitContext &emitContext){
    cout << "IntNode : " << value <<endl;
    return llvm::ConstantInt::get(llvm::Type::getInt32Ty(myContext),value,true);
}

llvm::Value* FloatNode::emitter(EmitContext &emitContext){
    cout << "FloatNode : " << value <<endl;
    return llvm::ConstantFP::get(llvm::Type::getFloatTy(myContext),value);
}

llvm::Value* CharNode::emitter(EmitContext &emitContext){  //----------  -_-
    cout << "CharNode : " << value <<endl;
    return myBuilder.getInt8(this->value);
}

llvm::Value* IdentifierNode::emitter(EmitContext &emitContext){
    cout << "IdentifierNode : " << name << endl;
    if(emitContext.getTop().find(name) == emitContext.getTop().end()){
        std::cerr << "undeclared variable " << name << endl;
        return NULL;
    }
    llvm::Type* tp = emitContext.getTopType()[name];
    return new llvm::LoadInst(tp,emitContext.getTop()[name], "LoadInst", false, emitContext.getCurrentBlock());
}

llvm::Value* ArrayElementNode::emitter(EmitContext &emitContext){  //返回了指向id[index]的指针，待定；
    llvm::Value* arrayValue = emitContext.getTop()[identifier.name];
    llvm::Value* indexValue = index.emitter(emitContext);
    vector<llvm::Value*> indexList;
    indexList.push_back(myBuilder.getInt32(0));
    indexList.push_back(indexValue);
    llvm::Value* elePtr =  myBuilder.CreateInBoundsGEP(arrayValue, llvm::ArrayRef<llvm::Value*>(indexList), "tmpvar");
    return elePtr;
    //return myBuilder.CreateAlignedLoad(elePtr, 4);
}

// llvm::Value* IntArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
// llvm::Value* FloatArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
// llvm::Value* CharArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-

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

llvm::Value* BinaryOpNode::emitter(EmitContext &emitContext){
    cout << "BinaryOpNode : " << op << endl;
    llvm::Value* left = lhs.emitter(emitContext);
    llvm::Value* right = rhs.emitter(emitContext);
    llvm::Instruction::BinaryOps bi_op;

    if(op == PLUS || op == MINUS || op == MUL || op == DIV){
        if(op == PLUS){bi_op = llvm::Instruction::Add;}
        else if(op == MINUS){bi_op = llvm::Instruction::Sub;}
        else if(op == MUL){bi_op = llvm::Instruction::Mul;}
        else if(op == DIV){bi_op = llvm::Instruction::SDiv;}
        return llvm::BinaryOperator::Create(bi_op,lhs.emitter(emitContext),rhs.emitter(emitContext),"",emitContext.getCurrentBlock());
    }
    else if(op == AND){
        if (left->getType() != llvm::Type::getInt1Ty(myContext) || right->getType() != llvm::Type::getInt1Ty(myContext)) {
                    throw logic_error("cannot use types other than bool in and exp");
                }
                return myBuilder.CreateAnd(left, right, "tmpAnd");
    }
    else if (op == OR) {
        if (left->getType() != llvm::Type::getInt1Ty(myContext) || right->getType() != llvm::Type::getInt1Ty(myContext)) {
                    throw logic_error("cannot use types other than bool in and exp");
                }
                return myBuilder.CreateOr(left, right, "tmpOR");
    }
    else{  //LT、GT、EQ、NEQ、LE、GE
        if (left->getType() != right->getType()) { //若左右的type类型不一致
            if (left->getType() == llvm::Type::getFloatTy(myContext)) 
            { right = typeCast(right, llvm::Type::getFloatTy(myContext));} 
            else {
                if (right->getType() == llvm::Type::getFloatTy(myContext)) 
                {
                    left = typeCast(left, llvm::Type::getFloatTy(myContext));
                } 
                else {
                    if (left->getType() == llvm::Type::getInt32Ty(myContext)) {
                        right = typeCast(right, llvm::Type::getInt32Ty(myContext));
                    } else if(right->getType() == llvm::Type::getInt32Ty(myContext)) {
                        left = typeCast(left, llvm::Type::getInt32Ty(myContext));
                    } else {
                        throw logic_error("cann't use bool in == != >= <= < >");
                    }
                }
            }
        }
        else if (op == EQU) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpOEQ(left, right, "fcmptmp") : myBuilder.CreateICmpEQ(left, right, "icmptmp");
        }
        else if (op == GEQ) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpOGE(left, right, "fcmptmp") : myBuilder.CreateICmpSGE(left, right, "icmptmp");
        }
        else if (op == LEQ) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpOLE(left, right, "fcmptmp") : myBuilder.CreateICmpSLE(left, right, "icmptmp");
        }
        else if (op == GREATERT) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpOGT(left, right, "fcmptmp") : myBuilder.CreateICmpSGT(left, right, "icmptmp");
        }
        else if (op == LESST) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpOLT(left, right, "fcmptmp") : myBuilder.CreateICmpSLT(left, right, "icmptmp");
        }
        else if (op == NEQ) {
            return (left->getType() == llvm::Type::getFloatTy(myContext)) ? myBuilder.CreateFCmpONE(left, right, "fcmptmp") : myBuilder.CreateICmpNE(left, right, "icmptmp");
        }
        return NULL;
    }
}

llvm::Value* AssignmentNode::emitter(EmitContext &emitContext){
    cout << "AssignmentNode,lhs: " << lhs.name << endl;
    if(emitContext.getTop().find(lhs.name) == emitContext.getTop().end()){ //未找到对应identifier
        cerr << "undeclared variable " << lhs.name << endl;
		return NULL;
    }
    return new llvm::StoreInst(rhs.emitter(emitContext), emitContext.getTop()[lhs.name], false, emitContext.getCurrentBlock());
}

llvm::Value* BlockNode::emitter(EmitContext &emitContext){
    llvm::Value* tmp = NULL;
    for(auto i : statementList){
        cout << "Generating code for " << typeid(*i).name() << endl;
        tmp = (*i).emitter(emitContext);
    }
    cout << "" << endl;
	return tmp;
}

llvm::Value* ExpressionStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for " << typeid(expression).name() << endl;
	return expression.emitter(emitContext);
}

llvm::Value* BreakStatementNode::emitter(EmitContext &emitContext){
    return myBuilder.CreateBr(GlobalAfterBB.top());
}

llvm::Value* IfElseStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for if-else"<<endl;
    llvm::Value *condValue = expression.emitter(emitContext), *thenValue = nullptr, *elseValue = nullptr;
    condValue = myBuilder.CreateICmpNE(condValue, llvm::ConstantInt::get(llvm::Type::getInt1Ty(myContext), 0, true), "ifCond");
    
    llvm::Function *TheFunction = myBuilder.GetInsertBlock()->getParent();
    
    llvm::BasicBlock *ThenBB = llvm::BasicBlock::Create(myContext, "then", TheFunction);
    llvm::BasicBlock *ElseBB = llvm::BasicBlock::Create(myContext, "else");
    llvm::BasicBlock *MergeBB = llvm::BasicBlock::Create(myContext, "ifcont");

    auto branch = myBuilder.CreateCondBr(condValue, ThenBB, ElseBB);
    myBuilder.SetInsertPoint(ThenBB);
    thenValue = ifBlock.emitter(emitContext);
    myBuilder.CreateBr(MergeBB);
    ThenBB = myBuilder.GetInsertBlock();

    myBuilder.SetInsertPoint(ElseBB);
    elseValue = elseBlock.emitter(emitContext);
    myBuilder.CreateBr(MergeBB);
    ElseBB = myBuilder.GetInsertBlock();

    myBuilder.SetInsertPoint(MergeBB);    
    return branch;
}

llvm::Value*  WhileStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for while "<<endl;

    llvm::Function *TheFunction = myBuilder.GetInsertBlock()->getParent();

    llvm::BasicBlock *condBB = llvm::BasicBlock::Create(myContext, "cond", TheFunction);
    llvm::BasicBlock *loopBB = llvm::BasicBlock::Create(myContext, "loop", TheFunction);
    llvm::BasicBlock *afterBB = llvm::BasicBlock::Create(myContext, "afterLoop", TheFunction);

     GlobalAfterBB.push(afterBB);

    myBuilder.CreateBr(condBB);
    myBuilder.SetInsertPoint(condBB);

    llvm::Value *condValue = expression.emitter(emitContext);
    condValue = myBuilder.CreateICmpNE(condValue, llvm::ConstantInt::get(llvm::Type::getInt1Ty(myContext), 0, true), "whileCond");
    auto branch = myBuilder.CreateCondBr(condValue, loopBB, afterBB);
    condBB = myBuilder.GetInsertBlock();

    myBuilder.SetInsertPoint(loopBB);
    block.emitter(emitContext);
    myBuilder.CreateBr(condBB);

    myBuilder.SetInsertPoint(afterBB);

    GlobalAfterBB.pop();
    return branch;
}

llvm::Value* ReturnStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating return code for " << typeid(expression).name() << endl;
	llvm::Value *rv = expression.emitter(emitContext);
	emitContext.setReturnValue(rv);
	return rv;
    //return myBuilder.CreateRet(rv);
}

llvm::Value* VariableDeclarationNode::emitter(EmitContext &emitContext){  
    if(size == 0){
        llvm::Type* llvmType = getLLvmType(type.name);
        cout << "Creating variable declaration " << type.name << " " << identifier.name<< endl;
        string *p;
        p = &identifier.name;
        emitContext.getTopType()[identifier.name] = llvmType;
        auto *block = emitContext.getCurrentBlock();
        //llvm::AllocaInst *alloc = new llvm::AllocaInst(llvmType,block->getParent()->getParent()->getDataLayout().getAllocaAddrSpace(),(identifier.name.c_str()), block);
        llvm::Value* alloc = CreateEntryBlockAlloca(emitContext.currentFunc, identifier.name, llvmType);
        // llvm::Value* alloc = CreateEntryBlockAlloca(context->get);
        emitContext.getTop()[identifier.name] = alloc;
        if (assignmentExpression != NULL) {
        AssignmentNode assn(identifier, *assignmentExpression,lineNo);
        assn.emitter(emitContext);
        }
        return alloc;
    }
    else{ //数组
        //llvm::Value *tmp = myBuilder.GetInsertBlock()->getParent()->getValueSymbolTable()->lookup(identifier.name);
        // if(tmp != nullptr){
        //     throw logic_error("Redefined Variable: " + it.first);
        // }
        if(emitContext.getTop().find(identifier.name) != emitContext.getTop().end()){
            throw logic_error("Redefined Variable: " + identifier.name);
        }
        llvm::Type* arrType = getArrayLLvmType(type.name, size);           
        llvm::Value* alloc = CreateEntryBlockAlloca(myBuilder.GetInsertBlock()->getParent(), identifier.name, arrType);
        return alloc;
    }

}

llvm::Value* FunctionDeclarationNode::emitter(EmitContext &emitContext){
    vector<llvm::Type*> argTypes;
    for(auto it : args){
        argTypes.push_back(getLLvmType((*it).type.name));
    }
	llvm::FunctionType *ftype = llvm::FunctionType::get(getLLvmType(type.name), makeArrayRef(argTypes), false);
	llvm::Function *function = llvm::Function::Create(ftype, llvm::GlobalValue::ExternalLinkage, identifier.name.c_str(), emitContext.myModule);
	llvm::BasicBlock *bblock = llvm::BasicBlock::Create(myContext, "entry", function, 0);

    emitContext.currentFunc = function;

	emitContext.pushBlock(bblock);

	llvm::Function::arg_iterator argsValues = function->arg_begin();
    llvm::Value* argumentValue;

    for(auto it : args){
        (*it).emitter(emitContext);
        argumentValue = &*argsValues++;
        argumentValue->setName((it)->identifier.name.c_str());
        llvm::StoreInst *inst = new llvm::StoreInst(argumentValue, emitContext.getTop()[(it)->identifier.name], false, bblock);
	}
	
	block.emitter(emitContext);
	llvm::ReturnInst::Create(myContext, emitContext.getReturnValue(), bblock);

	emitContext.popBlock();
	std::cout << "Creating function: " << identifier.name << endl;
	return function;
}