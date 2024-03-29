%{
    #include "treenode.h"
    #include <cstdio>
    #include <cstdlib>
    #define YYERROR_VERBOSE 1
	BlockNode *programBlock; // the root
	extern int yylex();
    extern int yylineno;
	void yyerror(const char *s) { std::printf("Error: %s", s); }
    void printError(int lineno, string s) { std::printf(" at: line: %d\n", lineno); }
%}

%error-verbose

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
%token <string> CONSTANT_INT CONSTANT_FLOAT CONSTANT_CHAR CONSTANT_STRING// 1, 1.0, 'a' "abc"
%token <token> PLUS MINUS MUL DIV // +, -, *, /
%token <token> AND OR // &&, ||
%token <token> NOT GAD // !, &
%token <token> EQU NEQ LESST GREATERT LEQ GEQ // ==, !=, <, >, <=, >=
%token <token> RETURN
%token <token> IF ELSE WHILE BREAK 


%left OR
%left AND
%left EQU NEQ LESST GREATERT LEQ GEQ
%left PLUS MINUS
%left MUL DIV
%right '!'
%left '(' ')' '[' ']'

%type <identifier> identifier
%type <expression> const_value expression
%type <statement> statement var_decl func_decl
%type <varibleDeclarationList> func_decl_args
%type <expressionList> call_args
%type <block> program statements block
/* %type <token> comparison */

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
    var_decl ';'
    | func_decl
    | expression ';' {
        $$ = new ExpressionStatementNode(*$1, yylineno);
    }
    | RETURN ';' {
        $$ = new ReturnVoidNode(yylineno);
    }
    | RETURN expression ';' {
        $$ = new ReturnStatementNode(*$2, yylineno);
    }
    | BREAK ';' {
        $$ = new BreakStatementNode(yylineno);
    }
    | IF '(' expression ')' block {
        $$ = new IfStatementNode(*$3, *$5, yylineno);
    }
    | IF '(' expression ')' block ELSE block {
        $$ = new IfElseStatementNode(*$3, *$5, *$7, yylineno);
    }
    | IF error ELSE block {
        printError(yylineno, "");
    }
    | WHILE '(' expression ')' block {
        $$ = new WhileStatementNode(*$3, *$5, yylineno);
    }
    | WHILE error ')' {
        printError(yylineno, "");
    }
    | WHILE error ']' {
        printError(yylineno, "");
    }
    | error ';' {
        printError(yylineno, "");
    }
    ;

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
    | identifier identifier '=' expression {
        $$ = new VariableDeclarationNode(*$1, *$2, $4, yylineno);
    }
    | identifier identifier '[' CONSTANT_INT ']' { // array
        $$ = new VariableDeclarationNode(*$1, *$2, atoi($4->c_str()), yylineno);
    }
    | identifier identifier '[' error ']' {
        printError(yylineno, "");
    }
    | identifier error {
        printError(yylineno, "");
    }
    | error identifier {
        printError(yylineno, "");
    }
    ;

func_decl: 
    identifier identifier '(' func_decl_args ')' block {
        $$ = new FunctionDeclarationNode(*$1, *$2, *$4, *$6, yylineno); // TODO: delete $4 ?
    }
    | identifier identifier error ')' {
        printError(yylineno, "");
    }
    ;
    
func_decl_args:
    {
        $$ = new std::vector<VariableDeclarationNode*>();
    }
    | var_decl {
        $$ = new std::vector<VariableDeclarationNode*>();
        $$->push_back($<variableDeclaration>1);
    }
    | func_decl_args ',' var_decl {
        $1->push_back($<variableDeclaration>3);
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
        $$ = new CharNode(*$1, yylineno);
    }
    | CONSTANT_STRING {
        $$ = new StringNode(*$1, yylineno);
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
        $1->push_back($3);
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
    | GAD identifier {
        $$ = new getAddrNode(*$2, yylineno);
    }
    | GAD identifier '[' expression ']' {
        $$ = new getArrayAddrNode(*$2, *$4, yylineno);
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
    | expression LESST expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression GREATERT expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression EQU expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression NEQ expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression LEQ expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | expression GEQ expression {
        $$ = new BinaryOpNode($2, *$1, *$3, yylineno);
    }
    | '(' expression ')' {
        $$ = $2;
    }
    | identifier '[' expression ']' { // array element access
        $$ = new ArrayElementNode(*$1, *$3, yylineno);
    }
    | identifier '[' expression ']' '=' expression { // array element access
        $$ = new ArrayElementAssignNode(*$1, *$3, *$6, yylineno);
    }
    | const_value
    | expression '=' error {
        printError(yylineno, "wrong assign expression");
    }
    | expression AND error {
        printError(yylineno, "");
    }
    | expression OR error {
        printError(yylineno, "");
    }
    | expression PLUS error {
        printError(yylineno, "");
    }
    | expression MINUS error {
        printError(yylineno, "");
    }
    | expression MUL error {
        printError(yylineno, "");
    }
    | expression DIV error {
        printError(yylineno, "");
    }
    | expression LESST error {
        printError(yylineno, "");
    }
    | expression GREATERT error {
        printError(yylineno, "");
    }
    | expression EQU error {
        printError(yylineno, "");
    }
    | expression NEQ error {
        printError(yylineno, "");
    }
    | expression LEQ error {
        printError(yylineno, "");
    }
    | expression GEQ error {
        printError(yylineno, "");
    }
    expression '[' error ']' {
        printError(yylineno, "");
    }
    ;
%%