%{
int compound = 0;
int simple = 0;
%}
%%
for\([^"\n]*\)\{[^"\n]*\} |
if\([^"\n]*\)\{[^"\n]*\} |
if\([^"\n]*\)\{[^"\n]*\}\nelse\{[^"\n]*\} |
while\([^"\n]*\)\{[^"\n]*\} |
do\{[^"\n]*\}\nwhile\([^"\n]*\) {compound++;}
. ;
[\n] ;
[\t] ;
%%
int main()
{
yyin=fopen("input.txt","r");
yylex();
printf("NOTE: Number of compound statements are : %d", compound);
return 0;
}
int yywrap()
{
return 1;
}