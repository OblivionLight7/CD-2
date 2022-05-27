%{ 
#include<stdio.h> 
int simple=1; 
%} 
%% 
[ \t\n]+[aA][nN][dD][ \t\n]+ {simple=0;} 
[ \t\n]+[oO][rR][ \t\n]+ {simple=0;} 
[ \t\n]+[bB][uU][tT][ \t\n]+ {simple=0;} 
. {;}
%%

main()
{
  printf("Enter the sentence: ");
  yylex();

  if(simple==1)
    printf("\nIt is a simple sentence\n");
  else
    printf("\nIt is a compound sentence\n");
}


int yywrap()
{
return 1;
}
