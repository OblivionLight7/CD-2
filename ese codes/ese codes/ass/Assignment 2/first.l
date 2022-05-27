%{

int count;

%}

%%

abc {printf(" %s is found", yytext);}
[0-9]+ {printf("%s is a number",yytext);}

%%

int main()
{
yylex();
}

int yywrap()
{
return 0;
}