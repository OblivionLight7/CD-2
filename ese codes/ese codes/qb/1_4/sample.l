%{
char *yylval;
int yylineno;
#include <string.h>
char arr[10][10];
int i = 0;
%}
%%
\n yylineno++; printf("\n");
[/t]+
break |
case |
char |
const |
continue |
default |
do |
double |
else |
enum |
extern |
float |
for |
goto |
if |
int |
long |
return |
sizeof |
struct |
switch |
void |
while { printf("%4d \t %8s \t Keyword\n", yylineno,yytext) ;}
[+\-*\/\.=] { printf("%4d \t %8s \t Operator\n", yylineno,yytext) ; }
"\"" { printf("%4d \t %8s \t Delimiter\n", yylineno, yytext) ; }
[;,\[\](){}<>\"] { printf("%4d \t %8s \t Delimiter\n", yylineno, yytext) ; }
[0-9] { printf("%4d \t %8s \t Number\n", yylineno, yytext) ; }
\"[^\"\n]*[\"\n] {yylval = strdup(yytext+1);
 if (yylval[yyleng-2] != '\"')
 printf("improperly terminated string\n");
 else
 yylval[yyleng-2] = 0;
 printf("%4d \t \"%8s\" \t Sting Constant\n",yylineno, yylval);}
[[:alpha:]][[:alnum:]]* { printf("%4d \t %8s \t identifier\n",yylineno, yytext);
 strcpy(arr[i],yytext) ;
 i++;
}
[0-9]([a-zA-Z]|[0-9]|[\_])* printf("%4d \t %8s \t invalid identifier\n",yylineno, yytext);
%%
int yywrap(){return 1;}


int main(int argc, char *argv[])
{

    yyin = fopen(argv[1], "rb+");

    printf("\n Line no. Lexeme \t Token \n");
    yylex();
    int size = sizeof(arr)/sizeof(arr[0]) ;
    printf("\n SYMBOL TABLE: \n");
    for(int i = 0 ; i < size ; i++)
    {
    printf(" %-4d %-4s \n", i+1, arr[i] );
    }


    return 0;
}



