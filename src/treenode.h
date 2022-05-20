#ifndef _TREENODE_H_

#define _TREENODE_H_

#include "llvm/ADT/STLExtras.h"
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <llvm/IR/Value.h>
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
public:
  int lineNo;
};

class ExpressionNode : public TreeNode {
public:
  ExpressionNode(int lineNo) : TreeNode(lineNo) {}
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
public:
  int value;
};

class FloatNode : public ExpressionNode {
public:
  FloatNode(float value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  float value;
};

class CharNode : public ExpressionNode {
public:
  CharNode(char value, int lineNo) : ExpressionNode(lineNo), value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  char value;
};

class IdentifierNode : public ExpressionNode {
public:
  IdentifierNode(string &name, int lineNo) : ExpressionNode(lineNo), name(name) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  string name;
};

class ArrayElementNode : public ExpressionNode {   //identifier[expression] 表示数组中某个元素
public:
  ArrayElementNode(IdentifierNode& identifier, ExpressionNode &index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  ExpressionNode  &index;
};

class ArrayElementAssignNode : public ExpressionNode {   //identifier[expression] 表示数组中某个元素
public:
  ArrayElementAssignNode(IdentifierNode &identifier, ExpressionNode &index, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  ExpressionNode &index;
  ExpressionNode &rhs;
};

// deprecated
// class IntArrayElementNode : public ExpressionNode {
// public:
//   IntArrayElementNode(IdentifierNode& identifier, int index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
//   llvm::Value *emitter(EmitContext &emitContext);
// public:
//   IdentifierNode& identifier;
//   int index;
// };

// deprecated
// class FloatArrayElementNode : public ExpressionNode {
// public:
//   FloatArrayElementNode(IdentifierNode& identifier, int index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
//   llvm::Value *emitter(EmitContext &emitContext);
// public:
//   IdentifierNode& identifier;
//   int index;
// };

// deprecated
// class CharArrayElementNode : public ExpressionNode { 
// public:
//   CharArrayElementNode(IdentifierNode& identifier, int index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
//   llvm::Value *emitter(EmitContext &emitContext);
// public:
//   IdentifierNode& identifier;
//   int index;
// };

class FunctionCallNode : public ExpressionNode {
public:
  FunctionCallNode(IdentifierNode &identifier, vector<ExpressionNode*> &args, int lineNo) : ExpressionNode(lineNo), identifier(identifier), args(args) {}
  FunctionCallNode(IdentifierNode &identifier, int lineNo) : ExpressionNode(lineNo), identifier(identifier) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  vector<ExpressionNode*> args;
};

class BinaryOpNode : public ExpressionNode {  //增加关系型二元运算
public:
  BinaryOpNode(int op, ExpressionNode &lhs, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), op(op), lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  int op;
  ExpressionNode& lhs;
  ExpressionNode& rhs;
};

class AssignmentNode : public ExpressionNode {
public:
  AssignmentNode(IdentifierNode &lhs, ExpressionNode &rhs, int lineNo) : ExpressionNode(lineNo), lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& lhs;
  ExpressionNode& rhs;
};

class BlockNode : public ExpressionNode {
public:
  BlockNode(int lineNo) : ExpressionNode(lineNo) {}
  BlockNode(vector<StatementNode*> statementList, int lineNo) : ExpressionNode(lineNo),  statementList(statementList) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  vector<StatementNode*> statementList;
};

class ExpressionStatementNode : public StatementNode {  //增加语句
public:
	ExpressionNode &expression;
	ExpressionStatementNode(ExpressionNode& expression, int lineNo) : StatementNode(lineNo),  expression(expression) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
};

class BreakStatementNode : public StatementNode {
public:
	BreakStatementNode(int lineNo) : StatementNode(lineNo) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
};

class IfElseStatementNode : public StatementNode {
public:
  IfElseStatementNode(ExpressionNode &expression, BlockNode &ifBlock, BlockNode &elseBlock, int lineNo)
    : StatementNode(lineNo), expression(expression), ifBlock(ifBlock), elseBlock(elseBlock) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  ExpressionNode &expression;
  BlockNode &ifBlock;
  BlockNode &elseBlock;
};

class WhileStatementNode : public StatementNode {
public:
  WhileStatementNode(ExpressionNode &expression, BlockNode &block, int lineNo)
    : StatementNode(lineNo), expression(expression), block(block) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  ExpressionNode &expression;
  BlockNode &block;
};

class ReturnStatementNode : public StatementNode {
public:
  ReturnStatementNode(ExpressionNode &expression, int lineNo) : StatementNode(lineNo), expression(expression) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  ExpressionNode &expression;
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
public:
  int size; // size != 0 means this is an array
  IdentifierNode &type;
  IdentifierNode &identifier;
  ExpressionNode *assignmentExpression;
};

// deprecated
// class ArrayDeclarationNode : public StatementNode {
// public:
//   ArrayDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier) {}
//   virtual llvm::Value* emitter(EmitContext &emitContext);
// public:
//   IdentifierNode &type;
//   int size;
//   IdentifierNode &identifier;
// };

class FunctionDeclarationNode : public StatementNode {
public:
  FunctionDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
    vector<VariableDeclarationNode*> args, BlockNode& block, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), args(args), block(block) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  IdentifierNode &type;
  IdentifierNode &identifier;
  BlockNode &block;
  vector<VariableDeclarationNode*> args;
};


#endif // _TREE_H_