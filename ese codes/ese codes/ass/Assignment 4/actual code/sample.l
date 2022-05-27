%option noyywrap
%{
#include"exp3.tab.h"
#include<math.h>
%}
%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) {yylval.dval=atof(yytext);return
NUMBER;}
e |
E {return E;}
log |
LOG {return LOG;}
ln |
LN { return LN;}
sin |
SIN {return SIN;}
cos |
COS {return COS;}
tan |
TAN {return TAN;}
cosec |
COSEC {return COSEC;}
sqrt |
SQRT {return SQRT;}
ceil |
CEILING {return CEILING;}
floor |
FLOOR {return FLOOR;}
mem {return MEM;}
[\t];
\$ return 0;
\n|. return yytext[0];
%%