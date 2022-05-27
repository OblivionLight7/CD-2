%{
#include<string.h>
#include<stdio.h>
int i=0;
%}

%%
([a-zA-Z0-9])* {i++;}

[\t]+ ;

[\n] ;

%%

int main(int argc, char *argv[])
{
    yylex();
    yyin = fopen(argv[1], "rb+");
    printf("Number of words are : %d", i);
    return 0;
}

int yywrap()
{
return(1);
}











