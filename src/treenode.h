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
  virtual ~TreeNode() {}
  virtual llvm::Value *emitter(EmitContext &emitContext) {
    return nullptr;
  }
public:
  int lineNo;
};

class ExpressionNode : public TreeNode {
public:
  virtual llvm::Value *emitter(EmitContext &emitContext);
};
class StatementNode : public TreeNode {
public:
  virtual llvm::Value *emitter(EmitContext &emitContext);
};

class IntNode : public ExpressionNode {
public:
  IntNode(int value) : value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  int value;
};

class DoubleNode : public ExpressionNode {
public:
  DoubleNode(double value) : value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  double value;
};

class CharNode : public ExpressionNode {
public:
  CharNode(char value) : value(value) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  char value;
};

class IdentifierNode : public ExpressionNode {
public:
  IdentifierNode(string &name) : name(name) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  string name;
};

class IntArrayElementNode : public ExpressionNode {
public:
  IntArrayElementNode(IdentifierNode& identifier, size_t index) : identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

class DoubleArrayElementNode : public ExpressionNode {
public:
  DoubleArrayElementNode(IdentifierNode& identifier, size_t index) : identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

class CharArrayElementNode : public ExpressionNode {
public:
  CharArrayElementNode(IdentifierNode& identifier, size_t index) : identifier(identifier), index(index) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  size_t index;
};

class FunctionCallNode : public ExpressionNode {
public:
  FunctionCallNode(IdentifierNode &identifier, vector<ExpressionNode*> &args) : 
    identifier(identifier), args(args) {}
  FunctionCallNode(IdentifierNode &identifier) : identifier(identifier) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& identifier;
  vector<ExpressionNode*> args;
};

class BinaryOpNode : public ExpressionNode {
public:
  BinaryOpNode(int op, ExpressionNode &lhs, ExpressionNode &rhs) : 
    op(op), lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  int op;
  ExpressionNode& lhs;
  ExpressionNode& rhs;
};

class AssignmentNode : public ExpressionNode {
public:
  AssignmentNode(IdentifierNode &lhs, ExpressionNode &rhs) : 
    lhs(lhs), rhs(rhs) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  IdentifierNode& lhs;
  ExpressionNode& rhs;
};

class BlockNode : public ExpressionNode {
public:
  BlockNode() {}
  BlockNode(vector<StatementNode*> statementList) : statementList(statementList) {}
  llvm::Value *emitter(EmitContext &emitContext);
public:
  vector<StatementNode*> statementList;
};

class ExpressionStatementNode : public StatementNode {
public:
	ExpressionNode &expression;
	ExpressionStatementNode(ExpressionNode& expression) : expression(expression) {}
	virtual llvm::Value* emitter(EmitContext &emitContext);
};

class ReturnStatementNode : public StatementNode {
public:
  ReturnStatementNode(ExpressionNode &expression) : expression(expression) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  ExpressionNode &expression;
};

class VariableDeclarationNode : public StatementNode {
public:
  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier) : 
    type(type), identifier(identifier), assignmentExpression(nullptr) {}
  VariableDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
    ExpressionNode *assignmentExpression) :
    type(type), identifier(identifier), assignmentExpression(assignmentExpression) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  IdentifierNode &type;
  IdentifierNode &identifier;
  ExpressionNode *assignmentExpression;
};

class ArrayDeclarationNode : public StatementNode {
public:
  ArrayDeclarationNode(IdentifierNode &type, IdentifierNode &identifier) : 
    type(type), identifier(identifier) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  IdentifierNode &type;
  size_t size;
  IdentifierNode &identifier;
};

class FunctionDeclarationNode : public StatementNode {
public:
  FunctionDeclarationNode(IdentifierNode &type, IdentifierNode &identifier, 
    vector<VariableDeclarationNode*> args, BlockNode& block) :
   type(type), identifier(identifier), args(args), block(block) {}
  virtual llvm::Value* emitter(EmitContext &emitContext);
public:
  IdentifierNode &type;
  IdentifierNode &identifier;
  BlockNode &block;
  vector<VariableDeclarationNode*> args;
};


#endif // _TREE_H_