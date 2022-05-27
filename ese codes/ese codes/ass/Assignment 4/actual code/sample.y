%{
#include<stdio.h>
#include<math.h>
#define e 2.718
double memvar;
%}
%union
{
double dval;
}
%token<dval>NUMBER
%token<dval>MEM
%token LOG LN SIN COS TAN SQRT CEILING FLOOR COSEC E
%left '-' '+'
%left '*' '/' '%'
%right '^'
%left LOG LN SIN COS TAN SQRT CEILING FLOOR COSEC E
%nonassoc UMINUS
%type<dval>expression
%%
start:statement'\n'
|start statement'\n'
;
statement:MEM'='expression {memvar=$3;}
| expression{printf("Result = %g\n",$1);}
;
expression:expression'+'expression {$$=$1+$3;}
| expression '-' expression {$$=$1-$3;}
| expression '*' expression {$$=$1*$3;}
| expression '/' expression
{ if($3==0){
yyerror("Arithmetic error: cannot divide by zero");
break;
}
else
$$=$1/$3;
}
|expression '%' expression {$$=fmod($1,$3);}
|expression '^'expression {$$=pow($1,$3);};
expression:'-'expression %prec UMINUS{$$=-$2;}
|'('expression')'{$$=$2;}
|LOG '('expression')' {$$=log($3)/log(10);}
|LN '('expression')' {$$=log($3)/log(e);}
|E '('expression')' {$$=pow(2.718,$3);}
|SIN '('expression')' {$$=sin($3*3.14/180);}
|COS '('expression')' {$$=cos($3*3.14/180);}
|TAN '('expression')' {$$=tan($3*3.14/180);}
|COSEC '('expression')' {$$=1/sin($3*3.14/180);}
|SQRT '('expression')' {$$=sqrt($3);}
|CEILING '('expression')' {$$=ceil($3);}
|FLOOR '('expression')' {$$=floor($3);}
|NUMBER {$$=$1;}
|MEM {$$=memvar;}
;
%%
int main()
{
printf("Enter a mathematical expression: ");
yyparse();
}
int yyerror(char *error)
{
printf("%s\n",error);
}