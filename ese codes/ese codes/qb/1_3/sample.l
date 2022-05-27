%{

%}

%%
[\t]+ ;  /*ignore whitespace*/

is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go     {printf("%s is a verb\n",yytext);}

very |
simply |
gently |
quietly |
calmly |
angrily {printf("%s is a adverb\n",yytext);}

to |
from |
behind |
above |
below |
between {printf("%s is a perposition\n",yytext);}

if |
then |
and |
but |
or  {printf("%s is a conjunction\n",yytext);}

their |
my |
Your |
his |
her |
its   {printf("%s is a adjective\n",yytext);}

she |
we |
they {printf("%s is a pronoun\n",yytext);}

ahh |
alas | 
alrighty | 
blah | 
dang | 
gee | 
nah | 
oops | 
phew | 
shucks | 
woops | 
yikes  {printf("%s is a interjection\n",yytext);}


man |
woman |
home |
office |
banana |
apple |
dog | 
monkey {printf("%s is a noun\n",yytext);}

[a-zA-Z]+ {printf("%s: is not recognized, may be noun\n", yytext);}

.|\n {ECHO;}

%%

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "rb+");
    yylex();
    return 0;
}
int yywrap()
{
    return(1);
}



























