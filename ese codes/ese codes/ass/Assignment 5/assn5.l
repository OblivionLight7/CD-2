%option noyywrap
%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
void yyerror(char *);
%}
%%
[ \t\n]+ ;
"if" {return IF;}
"else" {return ELSE;}
"=="|"<"|"<="|">"|">="|"!=" {return RELOP;}
[=,{}();] {return *yytext;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
[0-9]+ {return NUM;}
. {printf("\n\nlex err\n");}
%%