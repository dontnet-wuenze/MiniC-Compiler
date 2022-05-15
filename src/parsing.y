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
    | identifier identifier '[' INT ']' { // array
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
    INT {
        $$ = new IntNode(atoi($1->c_str()), yylineno);
    }
    | FLOAT {
        $$ = new FloatNode(atof($1->c_str()), yylineno);
    }
    | CHAR {
        $$ = new CharNode()
    }

expression:
    identifier '=' expression
%%