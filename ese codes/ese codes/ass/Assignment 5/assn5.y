%{
#include <stdio.h>
#include<stdlib.h>
%}
%token IF RELOP ID NUM ELSE
%%
ifelse : IF '(' COND ')' NEXT {printf("Valid if statement\n");exit(0);};
NEXT : BODY | BODY elsestate
elsestate : ELSE BODY
BODY : '{' ASSIGN ';' '}'|ASSIGN ';'
COND : S RELOP S|S;
ASSIGN : L '=' L;
S : ID|NUM;
L : ID|NUM;
%%
void yyerror(const char *error)
{
printf("%s\n",error);
exit(0);
}
int main()
{
printf("Enter statement : ");
yyparse();
}