#ifndef _TREENODE_H_

#define _TREENODE_H_

#include "llvm/ADT/STLExtras.h"
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <llvm/IR/Value.h>
#include <string>
#include <vector>

using namespace std;

class EmitContext;

class TreeNode {
public:
  TreeNode(int lineNo) : lineNo(lineNo) {}
  virtual ~TreeNode() {}
  virtual llvm::Value *emitter(EmitContext &emitContext) {
    return nullptr;
  }
  virtual void generateJson(string &s) {}
public:
  int lineNo;
};

class ExpressionNode : public TreeNode {
public:
  ExpressionNode(int lineNo) : TreeNode(lineNo) {}
  virtual llvm::Value *getAddr(EmitContext &emitContext) {
    return nullptr;
  }
  //virtual llvm::Value *emitter(EmitContext &emitContext);
};

class StatementNode : public TreeNode {
public:
  StatementNode(int lineNo) : TreeNode(lineNo) {}
  //virtual llvm::Value *emitter(EmitContext &emitContext);
};

class IntNode : public ExpressionNode {
public:
  IntNode(int value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  int value;
};

class FloatNode : public ExpressionNode {
public:
  FloatNode(float value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  float value;
};

class CharNode : public ExpressionNode {
public:
  CharNode(string &value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  string &value;
};

class StringNode : public ExpressionNode {
public:
  StringNode(string &value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
  llvm::Value *getAddr(EmitContext &emitContext);
  void generateJson(string &s);
public:
  string &value;
};

class IdentifierNode : public ExpressionNode {
public:
  IdentifierNode(string &name, int lineNo) : ExpressionNode(lineNo), name(name) {}
  llvm::Value *emitter(EmitContext &emitContext);
  llvm::Value *getAddr(EmitContext &emitContext);
  void generateJson(string &s);
public:
  string name;
};

class ArrayElementNode : public ExpressionNode {   //identifier[expression] 表示数组中某个元素
public:
  ArrayElementNode(IdentifierNode& identifier, ExpressionNode &index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
  llvm::Value *getAddr(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode& identifier;
  ExpressionNode  &index;
};

class ArrayElementAssignNode : public ExpressionNode {   //identifier[expression] 表示数组中某个元素
public:
  ArrayElementAssignNode(IdentifierNode &identifier, ExpressionNode &index, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode& identifier;
  ExpressionNode &index;
  ExpressionNode &rhs;
};

class FunctionCallNode : public ExpressionNode {
public:
  FunctionCallNode(IdentifierNode &identifier, vector<ExpressionNode*> &args, int lineNo) : ExpressionNode(lineNo), identifier(identifier), args(args) {}
  FunctionCallNode(IdentifierNode &identifier, int lineNo) : ExpressionNode(lineNo), identifier(identifier) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode& identifier;
  vector<ExpressionNode*> args;
};

class BinaryOpNode : public ExpressionNode {  //增加关系型二元运算
public:
  BinaryOpNode(int op, ExpressionNode &lhs, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), op(op), lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  int op;
  ExpressionNode& lhs;
  ExpressionNode& rhs;
};

class getAddrNode : public ExpressionNode {  //取地址运算符
public:
  getAddrNode(IdentifierNode &rhs, int lineNo) : ExpressionNode(lineNo), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode& rhs;
};

class getArrayAddrNode : public ExpressionNode {  //取地址运算符
public:
  getArrayAddrNode(IdentifierNode &rhs, ExpressionNode &index, int lineNo) : ExpressionNode(lineNo), index(index), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  ExpressionNode& index;
  IdentifierNode& rhs;
};

class AssignmentNode : public ExpressionNode {
public:
  AssignmentNode(IdentifierNode &lhs, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode& lhs;
  ExpressionNode& rhs;
};

class BlockNode : public ExpressionNode {
public:
  BlockNode(int lineNo) : ExpressionNode(lineNo) {}
  BlockNode(vector<StatementNode*> statementList, int lineNo) : ExpressionNode(lineNo),  statementList(statementList) {}
  llvm::Value *emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  vector<StatementNode*> statementList;
};

class ExpressionStatementNode : public StatementNode {  //增加语句
public:
	ExpressionNode &expression;
	ExpressionStatementNode(ExpressionNode& expression, int lineNo) : StatementNode(lineNo),  expression(expression) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
};

class BreakStatementNode : public StatementNode {
public:
	BreakStatementNode(int lineNo) : StatementNode(lineNo) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
};

class IfElseStatementNode : public StatementNode {
public:
  IfElseStatementNode(ExpressionNode &expression, BlockNode &ifBlock, BlockNode &elseBlock, int lineNo)
    : StatementNode(lineNo), expression(expression), ifBlock(ifBlock), elseBlock(elseBlock) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  ExpressionNode &expression;
  BlockNode &ifBlock;
  BlockNode &elseBlock;
};

class IfStatementNode : public StatementNode {
public:
  IfStatementNode(ExpressionNode &expression, BlockNode &ifBlock, int lineNo)
    : StatementNode(lineNo), expression(expression), ifBlock(ifBlock) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  ExpressionNode &expression;
  BlockNode &ifBlock;
};

class WhileStatementNode : public StatementNode {
public:
  WhileStatementNode(ExpressionNode &expression, BlockNode &block, int lineNo)
    : StatementNode(lineNo), expression(expression), block(block) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  ExpressionNode &expression;
  BlockNode &block;
};

class ReturnStatementNode : public StatementNode {
public:
  ReturnStatementNode(ExpressionNode &expression, int lineNo) : StatementNode(lineNo), expression(expression) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  ExpressionNode &expression;
};

class ReturnVoidNode : public StatementNode {
public:
  ReturnVoidNode(int lineNo) : StatementNode(lineNo) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
};

class VariableDeclarationNode : public StatementNode {  //增加数组的声明
public:
  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), size(0), assignmentExpression(nullptr) {}

  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
      int size, int lineNo) : 
        StatementNode(lineNo), type(type), identifier(identifier), size(size), assignmentExpression(nullptr) {}

  VariableDeclarationNode(IdentifierNode& type, IdentifierNode& identifier, 
    ExpressionNode *assignmentExpression, int lineNo) : 
        StatementNode(lineNo), type(type), identifier(identifier), assignmentExpression(assignmentExpression) {
        }

  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  int size; // size != 0 means this is an array
  IdentifierNode &type;
  IdentifierNode &identifier;
  ExpressionNode *assignmentExpression;
};

class FunctionDeclarationNode : public StatementNode {
public:
  FunctionDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
    vector<VariableDeclarationNode*> args, BlockNode& block, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), args(args), block(block) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
  void generateJson(string &s);
public:
  IdentifierNode &type;
  IdentifierNode &identifier;
  BlockNode &block;
  vector<VariableDeclarationNode*> args;
};


#endif // _TREE_H_