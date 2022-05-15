#ifndef _TREENODE_H_

#define _TREENODE_H_

#include "llvm/ADT/STLExtras.h"
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <llvm/IR/Value.h>
#include <sys/_types/_size_t.h>
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
  virtual llvm::Value *emitter(EmitContext &emitContext);
};
class StatementNode : public TreeNode {
public:
  StatementNode(int lineNo) : TreeNode(lineNo) {}
  virtual llvm::Value *emitter(EmitContext &emitContext);
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

class ArrayElementNode : public ExpressionNode {
public:
  ArrayElementNode(IdentifierNode& identifier, size_t index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

// deprecated
class IntArrayElementNode : public ExpressionNode {
public:
  IntArrayElementNode(IdentifierNode& identifier, size_t index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

// deprecated
class FloatArrayElementNode : public ExpressionNode {
public:
  FloatArrayElementNode(IdentifierNode& identifier, size_t index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

// deprecated
class CharArrayElementNode : public ExpressionNode { 
public:
  CharArrayElementNode(IdentifierNode& identifier, size_t index, int lineNo) : ExpressionNode(lineNo), identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

class FunctionCallNode : public ExpressionNode {
public:
  FunctionCallNode(IdentifierNode &identifier, vector<ExpressionNode*> &args, int lineNo) : ExpressionNode(lineNo), identifier(identifier), args(args) {}
  FunctionCallNode(IdentifierNode &identifier, int lineNo) : ExpressionNode(lineNo), identifier(identifier) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  vector<ExpressionNode*> args;
};

class BinaryOpNode : public ExpressionNode {
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

class ExpressionStatementNode : public StatementNode {
public:
	ExpressionNode &expression;
	ExpressionStatementNode(ExpressionNode& expression, int lineNo) : StatementNode(lineNo),  expression(expression) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
};

class ReturnStatementNode : public StatementNode {
public:
  ReturnStatementNode(ExpressionNode &expression, int lineNo) : StatementNode(lineNo), expression(expression) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  ExpressionNode &expression;
};

class VariableDeclarationNode : public StatementNode {
public:
  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), size(0), assignmentExpression(nullptr) {}

  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, size_t size, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), size(size), assignmentExpression(nullptr) {}

  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
    ExpressionNode *assignmentExpression, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier), assignmentExpression(assignmentExpression) {}

  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  size_t size; // size != 0 means this is an array
  IdentifierNode &type;
  IdentifierNode &identifier;
  ExpressionNode *assignmentExpression;
};

// deprecated
class ArrayDeclarationNode : public StatementNode {
public:
  ArrayDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, int lineNo) : StatementNode(lineNo), type(type), identifier(identifier) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  IdentifierNode &type;
  size_t size;
  IdentifierNode &identifier;
};

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