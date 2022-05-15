%{
    #include "treenode.h"
    #include <cstdio>
    #include <cstdlib>
	BlockNode *programBlock; // the root

	extern int yylex();
    extern int yylineno;
	void yyerror(const char *s) { std::printf("Error: %s\n", s);std::exit(1); }
%}

%union {
	TreeNode *node;
	BlockNode *block;
	ExpressionNode *expression;
	StatementNode *statement;
	IdentifierNode *identifier;
	VariableDeclarationNode *variableDeclaration;
	std::vector<VariableDeclarationNode*> *varibleDeclarationList;
	std::vector<ExpressionNode*> *expressionList;
	std::string *string;
	int token;
}

%token <string> IDENTIFIER 
%token <string> CONSTANT_INT CONSTANT_FLOAT CONSTANT_CHAR // 1, 1.0, 'a'
%token <token> INT FLOAT CHAR // int, float, char
%token <token> PLUS MINUS MUL DIV // +, -, *, /
%token <token> NOT AND OR // !, &&, ||
%token <token> EQ NEQ LT GT LE GE // ==, !=, <, >, <=, >=
%token <token> ASSIGN // =
%token <token> LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE // ()[]{}
%token <token> RETURN
%token <token> IF ELSE WHILE BREAK 



%right ASSIGN
%left OR
%left AND
%left EQ NEQ LT GT LE GE
%left PLUS MINUS
%left MUL DIV
%right NOT
%left LPAREN RPAREN LBRACKET RBRACKET

%type <identifier> identifier
%type <expression> const_value expression
%type <statement> statement var_decl func_decl
%type <varibleDeclarationList> func_decl_args
%type <expressionList> call_args
%type <block> program statements block
%type <token> comparison

%start program

%%

program: 
    statements { 
        programBlock = $1; 
    };

statements: 
    statement {
        $$ = new BlockNode(yylineno); 
        $$->statementList.push_back($<statement>1);
    }
    | statements statement {
        $1->statementList.push_back($<statement>2);
    };

statement: 
    var_decl 
    | func_decl
    | expression {
        $$ = new ExpressionStatementNode(*$1, yylineno);
    }
    | RETURN expression {
        $$ = new ReturnStatementNode(*$2, yylineno));
    };

block: 
    '{' statements '}' {
        $$ = $2;
    }
    | '{' '}' {
        $$ = new BlockNode(yylineno);
    };

var_decl:
    identifier identifier {
        $$ = new VariableDeclarationNode(*$1, *$2, yylineno);
    }
    | identifier identifier EQ expression {
        $$ = new VariableDeclarationNode(*$1, *$2, *$4, yylineno);
    }
    | identifier identifier '[' CONSTANT_INT ']' { // array
        $$ = new VariableDeclarationNode(*$1, *$2, $4, yylineno);
    }
    ;

func_decl: 
    identifier identifier '(' func_decl_args ')' block {
        $$ = new FunctionDeclarationNode(*$1, *$2, *$4, *$6, yylineno); // TODO: delete $4 ?
    };
    
func_decl_args:
    {
        $$ = new std::vector<VariableDeclarationNode*>();
    }
    | var_decl {
        $$ = new std::vector<VariableDeclarationNode*>();
        $$->push_back($<var_decl>1);
    }
    | func_decl_args ',' var_decl {
        $1->push_back($<var_decl>3);
    };

identifier:
    IDENTIFIER {
        $$ = new IdentifierNode(*$1, yylineno);
    };

const_value: 
    CONSTANT_INT {
        $$ = new IntNode(atoi($1->c_str()), yylineno);
    }
    | CONSTANT_FLOAT {
        $$ = new FloatNode(atof($1->c_str()), yylineno);
    }
    | CONSTANT_CHAR {
        $$ = new CharNode($1->at(0), yylineno);
    };

call_args:
    {
        $$ = new std::vector<ExpressionNode*>();
    }
    | expression {
        $$ = new std::vector<ExpressionNode*>();
        $$->push_back($1);
    }
    | call_args ',' expression {
        $1->push->back($3);
    };

expression:
    identifier '=' expression {
        $$ = new AssignmentNode(*$<identifier>1, *$3, yylineno);
    }
    | identifier '(' call_args ')' {
        $$ = new FunctionCallNode(*$1, *$3, yylineno);
    }
    | identifier {
        $<identifier>$ = $1;
    }
    | expression MUL expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression DIV expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression PLUS expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression MINUS expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression AND expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression OR expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression LT expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression GT expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression EQ expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression NEQ expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression LE expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression GE expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | '(' expression ')' {
        $$ = $2;
    }
    | identifier '[' expression ']' {
        $$ = new ArrayElementNode(*$1, $3, yylineno);
    }
    | const_value;
%%