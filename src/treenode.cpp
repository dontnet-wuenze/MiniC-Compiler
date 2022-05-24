#include "treenode.h"
#include "parsing.hpp"
#include "Emit.h"
#include <llvm-10/llvm/IR/BasicBlock.h>
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

llvm::Type* getPtrLLvmType(string type){ //对于指针形式，返回对应的LLVM的Type
    if(type == "int"){return llvm::Type::getInt32PtrTy(myContext);}
    else if(type == "float"){return llvm::Type::getFloatPtrTy(myContext);}
    else if(type == "char"){return llvm::Type::getInt8PtrTy(myContext);}
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
    else{return nullptr;}
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

// StringNode 返回值是首地址
llvm::Value* StringNode::emitter(EmitContext &emitContext) {
    cout << "StringNode : " << value <<endl;
    string str = value.substr(1, value.length() - 2);
    string after = string(1, '\n');
    int pos = str.find("\\n");
    while(pos != string::npos) {
        str = str.replace(pos, 2, after);
        pos = str.find("\\n");
    }
    llvm::Constant *strConst = llvm::ConstantDataArray::getString(myContext, str);
    
    llvm::Value *globalVar = new llvm::GlobalVariable(*(emitContext.myModule), strConst->getType(), true, llvm::GlobalValue::PrivateLinkage, strConst, "_Const_String_");
    vector<llvm::Value*> indexList;
    indexList.push_back(myBuilder.getInt32(0));
    indexList.push_back(myBuilder.getInt32(0));
    // var value
    llvm::Value * varPtr = myBuilder.CreateInBoundsGEP(globalVar, llvm::ArrayRef<llvm::Value*>(indexList), "tmpstring");
    return varPtr;
}

// StringNode 返回值是首地址
llvm::Value* StringNode::getAddr(EmitContext &emitContext) {
    cout << "StringNode : " << value <<endl;
    string str = value.substr(1, value.length() - 2);
    string after = string(1, '\n');
    int pos = str.find("\\n");
    while(pos != string::npos) {
        str = str.replace(pos, 2, after);
        pos = str.find("\\n");
    }
    llvm::Constant *strConst = llvm::ConstantDataArray::getString(myContext, str);
    
    llvm::Value *globalVar = new llvm::GlobalVariable(*(emitContext.myModule), strConst->getType(), true, llvm::GlobalValue::PrivateLinkage, strConst, "_Const_String_");
    vector<llvm::Value*> indexList;
    indexList.push_back(myBuilder.getInt32(0));
    indexList.push_back(myBuilder.getInt32(0));
    // var value
    llvm::Value * varPtr = myBuilder.CreateInBoundsGEP(globalVar, llvm::ArrayRef<llvm::Value*>(indexList), "tmpstring");
    return varPtr;
}

llvm::Value* IdentifierNode::emitter(EmitContext &emitContext){
    cout << "IdentifierNode : " << name << endl;

    llvm::Value* variable = emitContext.findVariable(name);
    if(variable == nullptr){
        std::cerr << "undeclared variable " << name << endl;
        return nullptr;
    }
    llvm::Type* tp = variable->getType()->getPointerElementType();
    llvm::outs()<<"identifier type:"<<*tp;
    cout<<endl;

    llvm::Value* res = nullptr;
    // 如果传入的是一个数组的 ID
    if(tp->isArrayTy()) {
        vector<llvm::Value*> indexList;
        indexList.push_back(myBuilder.getInt32(0));
        indexList.push_back(myBuilder.getInt32(0));
        res = myBuilder.CreateInBoundsGEP(variable, indexList, "arrayPtr");
    }
    else {
        res = new llvm::LoadInst(tp, variable, "LoadInst", false, myBuilder.GetInsertBlock());
    }
    return res;
}

llvm::Value* IdentifierNode::getAddr(EmitContext &emitContext){
    cout << "IdentifierNode : " << name << endl;

    llvm::Value* variable = emitContext.findVariable(name);
    if(variable == nullptr){
        std::cerr << "undeclared variable " << name << endl;
        return nullptr;
    }
    return variable;
}

llvm::Value* getArrayAddrNode::emitter(EmitContext &emitContext){
    cout<<"get arrayElement Addr:"<<rhs.name<<"[]"<<endl;

    llvm::Value* arrayValue = emitContext.findVariable(rhs.name);
    if(arrayValue == nullptr){
        cerr << "undeclared array " << rhs.name << endl;
		return nullptr;
    }
    // llvm::Value* arrayValue = emitContext.getTop()[identifier.name];
    llvm::Value* indexValue = index.emitter(emitContext);
    vector<llvm::Value*> indexList;


    // 如果是一个指针
    if(arrayValue->getType()->getPointerElementType()->isPointerTy()) {
        arrayValue = myBuilder.CreateLoad(arrayValue->getType()->getPointerElementType(), arrayValue);
        indexList.push_back(indexValue);    
    }
    // 如果是一个数组 
    else {
        indexList.push_back(myBuilder.getInt32(0));
        indexList.push_back(indexValue);    
    }

    llvm::Value* elePtr =  myBuilder.CreateInBoundsGEP(arrayValue, llvm::ArrayRef<llvm::Value*>(indexList), "elePtr");
    return elePtr;
    //return nullptr;
}


// 数组在表达式中返回的是值
llvm::Value* ArrayElementNode::emitter(EmitContext &emitContext){
    cout << "ArrayElementNode : " << identifier.name << "[]" << endl;

    llvm::Value* arrayValue = emitContext.findVariable(identifier.name);
    if(arrayValue == nullptr){
        cerr << "undeclared array " << identifier.name << endl;
		return nullptr;
    }

    llvm::Value* indexValue = index.emitter(emitContext);
    vector<llvm::Value*> indexList;

    // 如果是一个指针
    if(arrayValue->getType()->getPointerElementType()->isPointerTy()) {
        arrayValue = myBuilder.CreateLoad(arrayValue->getType()->getPointerElementType(), arrayValue);
        indexList.push_back(indexValue);    
    }
    // 如果是一个数组 
    else {
        indexList.push_back(myBuilder.getInt32(0));
        indexList.push_back(indexValue);    
    }

    llvm::Value* elePtr =  myBuilder.CreateInBoundsGEP(arrayValue, llvm::ArrayRef<llvm::Value*>(indexList), "tmparray");
    return myBuilder.CreateLoad(elePtr->getType()->getPointerElementType(), elePtr, "tmpvar");
    //return myBuilder.CreateAlignedLoad(elePtr, 4);
}

// 返回数组 array[index]的地址用来函数传参
llvm::Value* ArrayElementNode::getAddr(EmitContext &emitContext){
    cout << "getArrayElementNodeAddr : " << identifier.name << "[]" << endl;

    llvm::Value* arrayValue = emitContext.findVariable(identifier.name);
    if(arrayValue == nullptr){
        cerr << "undeclared array " << identifier.name << endl;
		return nullptr;
    }

    llvm::Value* indexValue = index.emitter(emitContext);
    vector<llvm::Value*> indexList;

    // 如果是一个指针
    if(arrayValue->getType()->getPointerElementType()->isPointerTy()) {
        arrayValue = myBuilder.CreateLoad(arrayValue->getType()->getPointerElementType(), arrayValue);
        indexList.push_back(indexValue);    
    }
    // 如果是一个数组 
    else {
        indexList.push_back(myBuilder.getInt32(0));
        indexList.push_back(indexValue);    
    }

    llvm::Value* elePtr =  myBuilder.CreateInBoundsGEP(arrayValue, llvm::ArrayRef<llvm::Value*>(indexList), "tmparray");
    return elePtr;
    //return myBuilder.CreateAlignedLoad(elePtr, 4);
}

llvm::Value* ArrayElementAssignNode::emitter(EmitContext &emitContext){
    cout<<"assign for arrayElementNode:"<<identifier.name<<"[]"<<endl;

    llvm::Value* arrayValue = emitContext.findVariable(identifier.name);
    if(arrayValue == nullptr){
        cerr << "undeclared array " << identifier.name << endl;
		return nullptr;
    }
    // llvm::Value* arrayValue = emitContext.getTop()[identifier.name];
    llvm::Value* indexValue = index.emitter(emitContext);
    vector<llvm::Value*> indexList;


    llvm::outs()<<"arrayIdentifier type:"<<*(arrayValue->getType());
    cout<<endl;

    // 如果是一个指针
    if(arrayValue->getType()->getPointerElementType()->isPointerTy()) {
        arrayValue = myBuilder.CreateLoad(arrayValue->getType()->getPointerElementType(), arrayValue);
        indexList.push_back(indexValue);    
    }
    // 如果是一个数组 
    else {
        indexList.push_back(myBuilder.getInt32(0));
        indexList.push_back(indexValue);    
    }
    llvm::Value* left =  myBuilder.CreateInBoundsGEP(arrayValue, llvm::ArrayRef<llvm::Value*>(indexList), "tmpvar");
    llvm::Value *right = rhs.emitter(emitContext);

    llvm::outs()<<*(left->getType()->getPointerElementType());

    if (right->getType() != left->getType()->getPointerElementType())
        right = typeCast(right, left->getType()->getPointerElementType());

    return myBuilder.CreateStore(right, left);
    //return nullptr;
}

// llvm::Value* IntArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
// llvm::Value* FloatArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-
// llvm::Value* CharArrayElementNode::emitter(EmitContext &emitContext){}//-----------  -_-

vector<llvm::Value *> *getPrintfArgs(EmitContext &emitContext,vector<ExpressionNode*>args){
    vector<llvm::Value *> *printf_args = new vector<llvm::Value *>;
    for(auto it: args){
        llvm::Value* tmp = it->emitter(emitContext);
        if (tmp->getType() == llvm::Type::getFloatTy(myContext))
            tmp = myBuilder.CreateFPExt(tmp, llvm::Type::getDoubleTy(myContext), "tmpdouble");
        printf_args->push_back(tmp);
    }
    return printf_args;
}

vector<llvm::Value *> *getScanfArgs(EmitContext &emitContext,vector<ExpressionNode*>args){
    vector<llvm::Value *> *scanf_args = new vector<llvm::Value *>;
    for(auto it: args){
        llvm::Value* tmp = it->emitter(emitContext);
        scanf_args->push_back(tmp);
    }
    return scanf_args;
}

vector<llvm::Value *> *getScanfArgsAddr(EmitContext &emitContext,vector<ExpressionNode*>args){
    vector<llvm::Value *> *scanf_args = new vector<llvm::Value *>;
    for(auto it: args){
        llvm::Value* tmp = it->getAddr(emitContext);
        scanf_args->push_back(tmp);
    }
    return scanf_args;

}

llvm:: Value* emitPrintf(EmitContext &emitContext,vector<ExpressionNode*> args){
    vector<llvm::Value *> *printf_args = getPrintfArgs(emitContext, args);    
    return myBuilder.CreateCall(emitContext.printf, *printf_args, "printf");
}

llvm:: Value* emitScanf(EmitContext &emitContext,vector<ExpressionNode*> args){
    //vector<llvm::Value *> *scanf_args = getScanfArgsAddr(emitContext, args);    
    vector<llvm::Value *> *scanf_args = getScanfArgs(emitContext, args);    
    return myBuilder.CreateCall(emitContext.scanf, *scanf_args, "scanf");
}

llvm::Value* FunctionCallNode::emitter(EmitContext &emitContext){
    if(identifier.name == "printf"){ //若调用printf函数
        return emitPrintf(emitContext, args);
    } else if(identifier.name == "scanf"){ //若调用scanf函数
        return emitScanf(emitContext, args);
    }

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
    llvm::CallInst *call = llvm::CallInst::Create(func,llvm::makeArrayRef(tmp),"",myBuilder.GetInsertBlock());
    cout << "Creating method call: " << identifier.name << endl;
	return call;

}

llvm::Value* BinaryOpNode::emitter(EmitContext &emitContext){
    cout << "BinaryOpNode : " << op << endl;
    llvm::Value* left = lhs.emitter(emitContext);
    llvm::Value* right = rhs.emitter(emitContext);
    llvm::Instruction::BinaryOps bi_op;

    if(op == PLUS || op == MINUS || op == MUL || op == DIV){
        if (left->getType() != right->getType()) {
            if (left->getType() == llvm::Type::getFloatTy(myContext)) {
                right = typeCast(right, llvm::Type::getFloatTy(myContext));
            } else {
                if (right->getType() == llvm::Type::getFloatTy(myContext)) {
                    left = typeCast(left, llvm::Type::getFloatTy(myContext));
                } else {
                    if (left->getType() == llvm::Type::getInt32Ty(myContext)) {
                        right = typeCast(right, llvm::Type::getInt32Ty(myContext));
                    } else if(right->getType() == llvm::Type::getInt32Ty(myContext)) {
                        left = typeCast(left, llvm::Type::getInt32Ty(myContext));
                    } else {
                        throw logic_error("cann't use bool in +-*/");
                    }
                }
            }
        }
        if(op == PLUS){bi_op = llvm::Instruction::Add;}
        else if(op == MINUS){bi_op = llvm::Instruction::Sub;}
        else if(op == MUL){bi_op = llvm::Instruction::Mul;}
        else if(op == DIV){bi_op = llvm::Instruction::SDiv;}
        return llvm::BinaryOperator::Create(bi_op,left,right,"", myBuilder.GetInsertBlock());
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

llvm::Value* getAddrNode::emitter(EmitContext &emitContext){
    cout << "getAddrNode : " << rhs.name << endl;
    // 在符号表和全局变量中查找
    llvm::Value* result = emitContext.findVariable(rhs.name);
    if(result == nullptr){
        cerr << "undeclared variable " << rhs.name << endl;
		return nullptr;
    }
    return result;
}

// identifier = expression
llvm::Value* AssignmentNode::emitter(EmitContext &emitContext){
    cout << "AssignmentNode,lhs: " << lhs.name << endl;
    
    // 在符号表和全局变量中查找
    llvm::Value* result = emitContext.findVariable(lhs.name);
    if(result == nullptr){
        cerr << "undeclared variable " << lhs.name << endl;
		return nullptr;
    }

    llvm::Value* right = rhs.emitter(emitContext);
    // 定位 block
    auto CurrentBlock = myBuilder.GetInsertBlock();
    
    if (right->getType() != result->getType()->getPointerElementType())
        right = typeCast(right, result->getType()->getPointerElementType());

    return new llvm::StoreInst(right, result, false, CurrentBlock);
}

llvm::Value* BlockNode::emitter(EmitContext &emitContext){
    llvm::Value* tmp = NULL;
    for(auto i : statementList){
        cout << "Generating code for " << typeid(*i).name() << endl;
        tmp = (*i).emitter(emitContext);
        // 若当前语句为 reutrn , 则后面的语句需要截断
        if(emitContext.hasReturn == true)
            break;
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

llvm::Value* IfStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for if-only"<<endl;

    
    llvm::Function *TheFunction = emitContext.currentFunc;
    
    llvm::BasicBlock *IfBB = llvm::BasicBlock::Create(myContext, "if", TheFunction);
    llvm::BasicBlock *ThenBB = llvm::BasicBlock::Create(myContext, "afterifonly",TheFunction);

    // 跳转判断语句
    llvm::Value *condValue = expression.emitter(emitContext), *thenValue = nullptr, *elseValue = nullptr;
    condValue = myBuilder.CreateICmpNE(condValue, llvm::ConstantInt::get(llvm::Type::getInt1Ty(myContext), 0, true), "ifCond");
    auto branch = myBuilder.CreateCondBr(condValue, IfBB, ThenBB);

    myBuilder.SetInsertPoint(IfBB);
    // 将 if 的域放入栈顶
    emitContext.pushBlock();
    ifBlock.emitter(emitContext);
    emitContext.popBlock();

    if(emitContext.hasReturn) 
        emitContext.hasReturn = false;
    // 跳过 else
    else
        myBuilder.CreateBr(ThenBB);

    myBuilder.SetInsertPoint(ThenBB);    
    return branch;
}

llvm::Value* IfElseStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for if-else"<<endl;

    
    llvm::Function *TheFunction = emitContext.currentFunc;
    
    llvm::BasicBlock *IfBB = llvm::BasicBlock::Create(myContext, "if", TheFunction);
    llvm::BasicBlock *ElseBB = llvm::BasicBlock::Create(myContext, "else",TheFunction);
    llvm::BasicBlock *ThenBB = llvm::BasicBlock::Create(myContext, "afterifelse",TheFunction);

    // 跳转判断语句
    llvm::Value *condValue = expression.emitter(emitContext), *thenValue = nullptr, *elseValue = nullptr;
    condValue = myBuilder.CreateICmpNE(condValue, llvm::ConstantInt::get(llvm::Type::getInt1Ty(myContext), 0, true), "ifCond");
    auto branch = myBuilder.CreateCondBr(condValue, IfBB, ElseBB);

    myBuilder.SetInsertPoint(IfBB);
    // 将 if 的域放入栈顶
    emitContext.pushBlock();
    ifBlock.emitter(emitContext);
    emitContext.popBlock();

    if(emitContext.hasReturn)
        emitContext.hasReturn = false;
    // 跳过 else
    else
        myBuilder.CreateBr(ThenBB);

    myBuilder.SetInsertPoint(ElseBB);
    // 将 else 的域放入栈顶
    emitContext.pushBlock();
    elseBlock.emitter(emitContext);
    emitContext.popBlock();

    if(emitContext.hasReturn)
        emitContext.hasReturn = false;
    else
        myBuilder.CreateBr(ThenBB);

    myBuilder.SetInsertPoint(ThenBB);    
    return branch;
}

llvm::Value*  WhileStatementNode::emitter(EmitContext &emitContext){
    cout << "Generating code for while "<<endl;

    llvm::Function *TheFunction = emitContext.currentFunc;

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

    // 将 while 的域放入栈顶
    emitContext.pushBlock();
    block.emitter(emitContext);
    if(emitContext.hasReturn)
        emitContext.hasReturn = false;
    else
        myBuilder.CreateBr(condBB);

    // while 结束, 将 while 的域弹出栈顶
    emitContext.popBlock();
    myBuilder.SetInsertPoint(afterBB);

    GlobalAfterBB.pop();
    return branch;
}

llvm::Value* ReturnStatementNode::emitter(EmitContext &emitContext){

    cout << "Generating return code for " << typeid(expression).name() << endl;
	llvm::Value *rv = expression.emitter(emitContext);
    if (rv->getType() != emitContext.returnVal->getType()->getPointerElementType())
        rv = typeCast(rv, emitContext.returnVal->getType()->getPointerElementType());
    myBuilder.CreateStore(rv, emitContext.returnVal);

    emitContext.hasReturn = true;
    return myBuilder.CreateBr(emitContext.returnBB);
}

llvm::Value* ReturnVoidNode::emitter(EmitContext &emitContext){
    
    cout << "Generating return code for void " << endl;

    emitContext.hasReturn = true;
    return myBuilder.CreateBr(emitContext.returnBB);
    //return myBuilder.CreateRetVoid();
}

llvm::Value* VariableDeclarationNode::emitter(EmitContext &emitContext) {  
    if(size == 0){ //普通变量
        llvm::Type* llvmType = getLLvmType(type.name);
        
        // 若当前函数为空, 说明是全局变量
        if(emitContext.currentFunc == nullptr) {
            cout << "Creating global variable declaration " << type.name << " " << identifier.name<< endl;
            llvm::Value *tmp = emitContext.myModule->getGlobalVariable(identifier.name, true);
            if(tmp != nullptr){
                throw logic_error("Redefined Global Variable: " + identifier.name);
            }
            llvm::GlobalVariable* globalVar = new llvm::GlobalVariable(*(emitContext.myModule), llvmType, false, llvm::GlobalValue::PrivateLinkage, 0, identifier.name);
            globalVar->setInitializer(llvm::ConstantInt::get(llvmType, 0));
            return nullptr;
        } else {
            cout << "Creating local variable declaration " << type.name << " " << identifier.name<< endl;
            //auto *block = myBuilder.GetInsertBlock();
            auto *block = myBuilder.GetInsertBlock();
            llvm::AllocaInst *alloc = new llvm::AllocaInst(llvmType,block->getParent()->getParent()->getDataLayout().getAllocaAddrSpace(),(identifier.name.c_str()), block);
            //llvm::Value* alloc = CreateEntryBlockAlloca(emitContext.currentFunc, identifier.name, llvmType);

            // 将新定义的变量类型和地址存入符号表中
            emitContext.getTopType()[identifier.name] = llvmType;
            emitContext.getTop()[identifier.name] = alloc;
            if (assignmentExpression != NULL) {
                AssignmentNode assn(identifier, *assignmentExpression,lineNo);
                assn.emitter(emitContext);
            }
            return alloc;
        }
    }
    else{ //数组
        llvm::Type* llvmType = getArrayLLvmType(type.name, size); 
        if(emitContext.currentFunc == nullptr) { //当前函数为空，为全局数组定义
            cout << "Creating global array declaration " << type.name << " " << identifier.name<< endl;
            llvm::Value *tmp = emitContext.myModule->getGlobalVariable(identifier.name, true);
            if(tmp != nullptr){
                throw logic_error("Redefined Global Array: " + identifier.name);
            }
            llvm::GlobalVariable* globalVar = new llvm::GlobalVariable(*(emitContext.myModule), llvmType, false, llvm::GlobalValue::PrivateLinkage, 0, identifier.name);
            
            std::vector<llvm::Constant*> constArrayElem;
            llvm::Constant* constElem = llvm::ConstantInt::get(llvmType->getArrayElementType(), 0);
            for (int i = 0; i < llvmType->getArrayNumElements(); i++) {
                constArrayElem.push_back(constElem);
            }
            llvm::Constant* constArray = llvm::ConstantArray::get(llvm::ArrayType::get(llvmType->getArrayElementType(), llvmType->getArrayNumElements()), constArrayElem);
            globalVar->setInitializer(constArray);
            return nullptr;
            
        }
        else {
            if(emitContext.isArgs) {
                // 如果是函数中定义的数组需要返回 指针类型
                cout << "Creating args array declaration " << type.name << " " << identifier.name<< endl;
                llvmType = getPtrLLvmType(type.name);
            } else {
                cout << "Creating local array declaration " << type.name << " " << identifier.name<< endl;
            }
            emitContext.getTopType()[identifier.name] = llvmType;
            auto *block = myBuilder.GetInsertBlock();
            llvm::AllocaInst *alloc = new llvm::AllocaInst(llvmType,block->getParent()->getParent()->getDataLayout().getAllocaAddrSpace(),(identifier.name.c_str()), block);
            emitContext.getTop()[identifier.name] = alloc;
            return alloc;
        }
    }

}

llvm::Value* FunctionDeclarationNode::emitter(EmitContext &emitContext){
    vector<llvm::Type*> argTypes;
    for(auto it : args){
        if(it->size == 0)
            argTypes.push_back(getLLvmType(it->type.name));
        else {
            argTypes.push_back(getPtrLLvmType(it->type.name));
        }
    }
	llvm::FunctionType *ftype = llvm::FunctionType::get(getLLvmType(type.name), makeArrayRef(argTypes), false);
	llvm::Function *function = llvm::Function::Create(ftype, llvm::GlobalValue::ExternalLinkage, identifier.name.c_str(), emitContext.myModule);
	llvm::BasicBlock *bblock = llvm::BasicBlock::Create(myContext, "entry", function, 0);

    myBuilder.SetInsertPoint(bblock);
    emitContext.currentFunc = function;
    emitContext.returnBB = llvm::BasicBlock::Create(myContext, "return", function, 0);

    // 定义一个变量用来存储函数的返回值
    if(type.name.compare("void") != 0) {
        emitContext.returnVal = new llvm::AllocaInst(getLLvmType(type.name), bblock->getParent()->getParent()->getDataLayout().getAllocaAddrSpace(), "", bblock);
    }
 
	emitContext.pushBlock();

 
	llvm::Function::arg_iterator argsValues = function->arg_begin();
    llvm::Value* argumentValue;

    emitContext.isArgs = true;
    for(auto it : args){
        (*it).emitter(emitContext);
        argumentValue = &*argsValues++;
        argumentValue->setName((it)->identifier.name.c_str());
        llvm::StoreInst *inst = new llvm::StoreInst(argumentValue, emitContext.getTop()[(it)->identifier.name], false, bblock);
	}
    emitContext.isArgs = false;
	
	block.emitter(emitContext);
    emitContext.hasReturn = false;

    myBuilder.SetInsertPoint(emitContext.returnBB);
    if(type.name.compare("void") == 0) {
        myBuilder.CreateRetVoid();
    } else {
        llvm::Value* ret = myBuilder.CreateLoad(getLLvmType(type.name), emitContext.returnVal, "");
        myBuilder.CreateRet(ret);
    }

	emitContext.popBlock();
    emitContext.currentFunc = nullptr;
	std::cout << "Creating function: " << identifier.name << endl;
	return function;
}

/*
--------------------- Generate Json ----------------------
*/


void IntNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"IntValue: " + to_string(this->value) + "\"\n");
    s.append("}");
}

void FloatNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"FloatValue: " + to_string(this->value) + "\"\n");
    s.append("}");
}

void CharNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"CharValue: " + to_string(this->value) + "\"\n");
    s.append("}");
}

void StringNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"StringValue: " + this->value.substr(1, this->value.length() - 2) + "\"\n");
    s.append("}");
}

void IdentifierNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"Identifier: " + this->name + "\"\n");
    s.append("}");
}

void ArrayElementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"ArrayElement\",\n");
    s.append("\"children\" : \n[");
    
    this->identifier.generateJson(s);
    s.append(",");
    this->index.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void ArrayElementAssignNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"ArrayElementAssign\",\n");
    s.append("\"children\" : \n[");
    
    this->identifier.generateJson(s);
    s.append(",");
    this->index.generateJson(s);
    s.append(",");
    this->rhs.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void FunctionCallNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"FunctionCall\",\n");
    s.append("\"children\" : \n[");
    
    this->identifier.generateJson(s);
    
    if (!this->args.empty())
        s.append(",");

    for (TreeNode* node : this->args) {
        node->generateJson(s);
        if (node != this->args.back()) {
            s.append(",");
        }
    }

    s.append("\n]\n");
    s.append("}");
}

string getOpStr(int op) {
    string opStr;
    switch (op) {
    case PLUS : { opStr = "+"; break;}
    case MINUS : { opStr = "-"; break;}
    case MUL : { opStr = "*"; break;}
    case DIV : { opStr = "/"; break;}
    case OR : { opStr = "||"; break;}
    case AND : { opStr = "&&"; break;}
    case EQU : { opStr = "=="; break;}
    case NEQ : { opStr = "!="; break;}
    case LESST : { opStr = "<"; break;}
    case GREATERT : { opStr = ">"; break;}
    case LEQ : { opStr = "<="; break;}
    case GEQ : { opStr = ">="; break;}
    default: {
        cout << "ERROR" << op << endl;
    }
    }
    return opStr;
}

void BinaryOpNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"BinaryOperation\",\n");
    s.append("\"children\" : \n[");
    
    this->lhs.generateJson(s);
    s.append(",");
    
    string opStr = getOpStr(this->op);

    s.append("\n{\n");
    s.append("\"name\" : \"" + opStr + "\"\n");
    s.append("}");

    s.append(",");
    this->rhs.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void getAddrNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"getAddr\",\n");
    s.append("\"children\" : \n[");
    
    this->rhs.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void getArrayAddrNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"getArrayAddr\",\n");
    s.append("\"children\" : \n[");
    
    this->rhs.generateJson(s);

    s.append(",");

    this->index.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void AssignmentNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"Assignment\",\n");
    s.append("\"children\" : \n[");
    
    this->lhs.generateJson(s);
    s.append(",");
    this->rhs.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void BlockNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"Block\",\n");
    s.append("\"children\" : \n[");
    for (TreeNode* node : this->statementList) {
        node->generateJson(s);
        if (node != this->statementList.back()) {
            s.append(",");
        }
    }
    s.append("\n]\n");
    s.append("}");
}

void ExpressionStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"ExpressionStatement\",\n");
    s.append("\"children\" : \n[");
    this->expression.generateJson(s);
    s.append("\n]\n");
    s.append("}");
}

void BreakStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : break\n");
    s.append("}");
}

void IfStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"IfOnlyStatement\",\n");
    s.append("\"children\" : \n[");
    
    this->expression.generateJson(s);
    s.append(",");
    this->ifBlock.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void IfElseStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"IfElseStatement\",\n");
    s.append("\"children\" : \n[");
    
    this->expression.generateJson(s);
    s.append(",");
    this->ifBlock.generateJson(s);
    s.append(",");
    this->elseBlock.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void WhileStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"WhileStatement\",\n");
    s.append("\"children\" : \n[");
    
    this->expression.generateJson(s);
    s.append(",");
    this->block.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}

void ReturnStatementNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"ReturnStatement\",\n");
    s.append("\"children\" : \n[");
    this->expression.generateJson(s);
    s.append("\n]\n");
    s.append("}");
}

void ReturnVoidNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"ReturnVoid\",\n");
    s.append("\"children\" : \n[");
    s.append("\n]\n");
    s.append("}");
}

void VariableDeclarationNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"VariableDeclaration\",\n");
    s.append("\"children\" : \n[");
    
    this->type.generateJson(s);
    s.append(",");
    this->identifier.generateJson(s);

    if (this->assignmentExpression != nullptr) {
        s.append(",");
        this->assignmentExpression->generateJson(s);
    }

    s.append("\n]\n");
    s.append("}");
}

void FunctionDeclarationNode::generateJson(string &s) {
    s.append("\n{\n");
    s.append("\"name\" : \"FunctionDeclaration\",\n");
    s.append("\"children\" : \n[");
    
    this->type.generateJson(s);
    s.append(",");
    this->identifier.generateJson(s);
    
    s.append(",");

    for (TreeNode* node : this->args) {
        node->generateJson(s);
        s.append(",");
    }

    this->block.generateJson(s);

    s.append("\n]\n");
    s.append("}");
}
