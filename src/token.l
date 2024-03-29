D            [0-9]
L            [a-zA-Z_]
H            [a-fA-F0-9]
E            ([Ee][+-]?{D}+)

%{
#include <stdio.h>
#include <iostream>
#include <string>
#include "treenode.h"
#include "parsing.hpp"

#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token = t)

int column = 0;

void count(void);
void comment(void);
%}

%option yylineno

%%
    /* match two types of comments */
"/*"            { comment();               }
"//"[^\n]*      { /* consume //-comment */ }

    /* match all the necessary keywords */
"break"         { count(); return TOKEN(BREAK);    }
"else"          { count(); return TOKEN(ELSE);     }
"if"            { count(); return TOKEN(IF);       }
"return"        { count(); return TOKEN(RETURN);   }
"while"         { count(); return TOKEN(WHILE);    }

    /* identifiers */
{L}({L}|{D})*            { count(); SAVE_TOKEN; return IDENTIFIER;}

    /* constants */
0[xX]{H}+                { count(); SAVE_TOKEN; return CONSTANT_INT; /* hexadecimal */ }
0[0-7]*                  { count(); SAVE_TOKEN; return CONSTANT_INT; /* octal */       }
[1-9]{D}*                { count(); SAVE_TOKEN; return CONSTANT_INT; /* decimal */     }

\'.\'|\'\\.\'            { count(); SAVE_TOKEN; return CONSTANT_CHAR; /* character */  }
\"(\\.|[^"\\])*\"      { count(); SAVE_TOKEN; return CONSTANT_STRING; /* string */    }


{D}+{E}                  { count(); SAVE_TOKEN; return CONSTANT_FLOAT; }
{D}*"."{D}+{E}?          { count(); SAVE_TOKEN; return CONSTANT_FLOAT; }
{D}+"."{D}*{E}?          { count(); SAVE_TOKEN; return CONSTANT_FLOAT; }


    /* operators */
"&&"            { count(); return TOKEN(AND); }
"||"            { count(); return TOKEN(OR); }
"<="            { count(); return TOKEN(LEQ); }
">="            { count(); return TOKEN(GEQ); }
"=="            { count(); return TOKEN(EQU); }
"!="            { count(); return TOKEN(NEQ); }
";"             { count(); return TOKEN(';'); }
"{"             { count(); return TOKEN('{'); }
"}"             { count(); return TOKEN('}'); }
","             { count(); return TOKEN(','); }
":"             { count(); return TOKEN(':'); }
"="             { count(); return TOKEN('='); }
"("             { count(); return TOKEN('('); }
")"             { count(); return TOKEN(')'); }
"["             { count(); return TOKEN('['); }
"]"             { count(); return TOKEN(']'); }
"."             { count(); return TOKEN('.'); }
"&"             { count(); return TOKEN(GAD); }
"!"             { count(); return TOKEN(NOT); }
"~"             { count(); return TOKEN('~'); }
"-"             { count(); return TOKEN(MINUS); }
"+"             { count(); return TOKEN(PLUS); }
"*"             { count(); return TOKEN(MUL); }
"/"             { count(); return TOKEN(DIV); }
"%"             { count(); return TOKEN('%'); }
"<"             { count(); return TOKEN(LESST); }
">"             { count(); return TOKEN(GREATERT); }
"^"             { count(); return TOKEN('^'); }
"|"             { count(); return TOKEN('|'); }
"?"             { count(); return TOKEN('?'); }

[ \t\v\n\f]     { count(); }
.               { printf("unknown token : %s in line: %d\n", yytext, yylineno); }

%%

int yywrap(void)
{
    return 1;
}


void comment(void)
{
    column = 0;
    char c, prev = 0;
    
    while (std::cin >> c)      /* (EOF maps to 0) */
    {
        if (c == '/' && prev == '*')
            return;
        prev = c;
    }
    printf("unterminated comment");
}

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

    
}
