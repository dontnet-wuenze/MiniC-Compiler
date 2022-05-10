D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			([Ee][+-]?{D}+)

%{
#include <stdio.h>
#include "y.tab.h"
#include "tree.h"

void count(void);
%}

%option yylineno

%%
/* match two types of comments */
"/*"			{ comment(); }
"//"[^\n]*      { /* consume //-comment */ }

/* match all the necessary keywords */
"bool"          { count(); yylavl.tree_node = new Node(yytext); return(BOOL); }
"break"			{ count(); yylavl.tree_node = new Node(yytext); return(BREAK); }
"char"			{ count(); yylavl.tree_node = new Node(yytext); return(CHAR); }
"continue"		{ count(); yylavl.tree_node = new Node(yytext); return(CONTINUE); }
"else"			{ count(); yylavl.tree_node = new Node(yytext); return(ELSE); }
"false" 		{ count(); yylavl.tree_node = new Node(yytext); return(FALSE)};
"float"			{ count(); yylavl.tree_node = new Node(yytext); return(FLOAT); }
"for"			{ count(); yylavl.tree_node = new Node(yytext); return(FOR); }
"if"			{ count(); yylavl.tree_node = new Node(yytext); return(IF); }
"int"			{ count(); yylavl.tree_node = new Node(yytext); return(INT); }
"return"		{ count(); yylavl.tree_node = new Node(yytext); return(RETURN); }
"true"			{ count(); yylavl.tree_node = new Node(yytext); return(TRUE); }
"void"			{ count(); yylavl.tree_node = new Node(yytext); return(VOID); }
"while"			{ count(); yylavl.tree_node = new Node(yytext); return(WHILE); }

/* identifiers */
{L}({L}|{D})*		{ count(); return(check_type()); }

/* constants */
0[xX]{H}+		{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_INT); /* hexadecimal */ }
0[0-7]*		{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_INT); /* octal */ }
[1-9]{D}*		{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_INT); /* decimal */ }

\'.\'|\'\\.\'        { count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_CHAR); /* character */ }
L?'(\\.|[^\\'\n])+'	{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_STRING); /* string */}


{D}+{E}		{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_FLOAT); }
{D}*"."{D}+{E}?	{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_FLOAT); }
{D}+"."{D}*{E}?	{ count(); yylavl.tree_node = new Node(yytext); return(CONSTANT_FLOAT); }


"+="			{ count(); return(ADD_ASSIGN); }
"-="			{ count(); return(SUB_ASSIGN); }
"*="			{ count(); return(MUL_ASSIGN); }
"/="			{ count(); return(DIV_ASSIGN); }
"%="			{ count(); return(MOD_ASSIGN); }
"&="			{ count(); return(AND_ASSIGN); }
"^="			{ count(); return(XOR_ASSIGN); }
"|="			{ count(); return(OR_ASSIGN); }
"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"=="			{ count(); return(EQ_OP); }
"!="			{ count(); return(NE_OP); }
";"			{ count(); return(';'); }
"{"		{ count(); return('{'); }
"}"		{ count(); return('}'); }
","			{ count(); return(','); }
":"			{ count(); return(':'); }
"="			{ count(); return('='); }
"("			{ count(); return('('); }
")"			{ count(); return(')'); }
"["		{ count(); return('['); }
"]"		{ count(); return(']'); }
"."			{ count(); return('.'); }
"&"			{ count(); return('&'); }
"!"			{ count(); return('!'); }
"~"			{ count(); return('~'); }
"-"			{ count(); return('-'); }
"+"			{ count(); return('+'); }
"*"			{ count(); return('*'); }
"/"			{ count(); return('/'); }
"%"			{ count(); return('%'); }
"<"			{ count(); return('<'); }
">"			{ count(); return('>'); }
"^"			{ count(); return('^'); }
"|"			{ count(); return('|'); }
"?"			{ count(); return('?'); }

[ \t\v\n\f]		{ count(); }
.			{ /* Add code to complain about unmatched characters */ }

%%

int yywrap(void)
{
	return 1;
}


void comment(void)
{
	column = 0;
	char c, prev = 0;
	
	while (cin >> c)      /* (EOF maps to 0) */
	{
		if (c == '/' && prev == '*')
			return;
		prev = c;
	}
	printf("unterminated comment");
}


int column = 0;

void count(void)
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 4 - (column % 4);
		else
			column++;

	ECHO;
}


int check_type(void)
{
/*
* pseudo code --- this is what it should check
*
*	if (yytext == type_name)
*		return TYPE_NAME;
*
*	return IDENTIFIER;
*/

/*
*	it actually will only return IDENTIFIER
*/

	return IDENTIFIER;
}