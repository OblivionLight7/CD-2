%{
/*
* ASSIGNMENT 3 SUBSET OF C LANG
*/

#include<stdio.h>
#include<string.h>
enum {	
	LOOKUP = 0, /* default - looking rather than defining. */
	KEYWORD,
	DELIMITER,
	CONSTANT,
	OPERATOR,
	IDENTIFIER
};	
	
int state;
int add_word(int type, char *word) ;
int lookup_word(char *word) ;

int add_num(int type, int num);
int lookup_num(int num);
%}



%%

\n { state = LOOKUP; }

^keyword|KEYWORD { state = KEYWORD;}
^delimiter|DELIMITER { state = DELIMITER;}
^constant|CONSTANT { state = CONSTANT;}
^operator|OPERATOR { state = OPERATOR;}
^identifier|IDENTIFIER { state = IDENTIFIER;}


[a-zA-z]+ 	{if (state != LOOKUP){
					//then we define the current word
					add_word(state, yytext);
					} else{
							switch(lookup_word(yytext)){
								case KEYWORD: printf("%s is a Keyword\n", yytext); break;
								case DELIMITER: printf("%s is Delimiter\n", yytext); break;
								case CONSTANT: printf("%s is Constant\n", yytext); break;
								case OPERATOR: printf("%s is Operator\n", yytext); break;
								case IDENTIFIER: printf("%s is Identifier\n", yytext); break;
								default: printf("%s not recognized\n",yytext);
								break;
							}//switch ends here
			    		}//else ends here
				}//main action bracket


"+"|"-"|"*"|"%"|"/"|"++"|"--"|"=="|"<"|">"|"<="|">="|"="			{if (state != LOOKUP){
																						add_word(state, yytext);
																					} else{
																							switch(lookup_word(yytext)){
																								case OPERATOR: printf("%s is an Operator\n",yytext); break;
																								default:
																									printf("%s is not recognized\n",yytext);
																									break;
																							}//switch ends here
																							
																						}//else ends here
																					}//main bracket ends


"("|")"|"{"|"}"|"["|"]"|";"|","			{if (state != LOOKUP){
														add_word(state, yytext);
													} else{
															switch(lookup_word(yytext)){
																case DELIMITER: printf("%s is an Delimiter\n",yytext); break;
																default:
																	printf("%s is not recognized\n",yytext);
																	break;
															}//switch ends here
															
														}//else ends here
													}//main bracket ends



[0-9]+	{if (state != LOOKUP){
				add_word(state, yytext);
			} else {
				switch(lookup_word(yytext)){
					case CONSTANT: printf("%s is a Constant\n",yytext); break;

					default: 
						printf("%s is not recognized\n",yytext); break;
				}
			}
			}//main bracket ends here



.	//ignore anything else


%%



int main(int argc, char* argv[])
{
	yylex();
}

//define a linked list
struct word{
	char * word_name;
	int word_type;
	struct word *next;
};

//root node declaration
struct word *word_list;



int add_word(int type, char* word)
{
	struct word *wp;

	if(lookup_word(word) != LOOKUP)
	{
		printf("ERROR: %s word is already declared!\n", yytext);
		return 0;
	}

	//word not in linked list
	wp = (struct word*)malloc(sizeof(struct word));
	wp->next=word_list;
	
	//copying the word 
	wp->word_name = (char*)malloc(strlen(word)+1);
	strcpy(wp->word_name, word);
	wp->word_type=type;
	word_list=wp;
	return 1;	//if added word

}


int lookup_word(char* word)
{
	struct word *wp= word_list;
	for(;wp;wp=wp->next)
	{
		if(strcmp(wp->word_name, word)==0)
		{
			return wp->word_type;
		}
	}
	return LOOKUP;	//not found
}



int yywrap()
{
	return 1;
}

