%{
#include<string.h>
#include<stdio.h>
int i=0;
%}

%%
([a-zA-Z0-9])* {i++;}

"\n" {printf("The number of words are %d\n",i);i=0;}

%%

int main(){
    yylex();
}

int yywrap()
{
return 0;
}











