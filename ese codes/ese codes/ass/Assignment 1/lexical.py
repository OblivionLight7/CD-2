
# delim = {' ',',',';','(', ')' ,'[',']','{','}'}
# operator = {'+', '-','*' ,'/','>','<','=','++', '--'}
# keyword = {'args','String','abstract','boolean','break','byte','case','catch','char','class','continue','default','do','double','else','enum','extends','final','finally','float','for','if','implements','import','instanceof','int','interface','long','native','new','null','package','private','protected','public','return','short','static','strictfp','super','switch','synchronized','this','throw','throws','transient','try','void','volatile','while'}
# number = {'0','1','2','3','4','5','6','7','8','9'}

delim = [' ',',',';','(', ')' ,'[',']','{','}']
operator = ['+', '-','*' ,'/','>','<','=','++', '--']
keyword = ['String','abstract','boolean','break','byte','case','catch','char','class','continue','default','do','double','else','enum','extends','final','finally','float','for','if','implements','import','instanceof','int','interface','long','native','new','null','package','private','protected','public','return','short','static','strictfp','super','switch','synchronized','this','throw','throws','transient','try','void','volatile','while']
number = ['0','1','2','3','4','5','6','7','8','9']

special_characters = "!@#$&?/"
line_num=[]
symbols=[]
tokenvalues=[]
lexeme=[]
token=[]
double=['"']
symbolline=[]



import pandas as pd
import re
from tabulate import tabulate
with open("sample.txt") as file:
    lines = [line.rstrip() for line in file]

def ispresent(sub):
    # if (sub=="System.out.println"):
    #     return False
    if sub in symbols:
        return False
    return True
    

def isDelim(char):
    if char in delim:
        return True;
    return False;

def isOperator(char):
    if char in operator:
        return True;
    return False;

def isKeyword(sub):
    if sub in keyword:
        return True;
    return False;
     
def isValid(sub):
    if(sub[0].isdigit() or (any(c in special_characters for c in sub))):
        return False;
    return True;
  
def parser(line,i):
    left = 0
    right = 0
    length = len(line)-1
    while (right <= length and left <= right):
        # print("************************************")
        # print(line[left])
            # 
        # print(line[right])
        # print("************************************")
        if (isDelim(line[right]) == False):
                right = right+1
        if (isDelim(line[right]) == True and left == right):
            lexeme.append(line[right])
            line_num.append(i+1)
            token.append("Delimiter")
            for i in range(0,len(delim)):
                if(line[right]==delim[i]):
                    tokenvalues.append("DL "+ str(i) )
                    break

            
            right = right+1
            left = right
        elif (isDelim(line[right]) == True and left != right or (right == len and left != right)):
            line_num.append(i+1)
            sub = line[left:right]
            x = len(sub)    
            if (isKeyword(sub) == True):
                lexeme.append(sub)
                token.append("Keyword")
                for i in range(0,len(keyword)):
                    if(sub==keyword[i]):
                        tokenvalues.append("KEY "+ str(i) )
                        break
            elif (isOperator(sub) == True):
                lexeme.append(sub)
                token.append("Operator")
                for i in range(0,len(operator)):
                    if(sub==operator[i]):
                        tokenvalues.append("OP "+ str(i) )
                        break
                # print(sub,"keyword")
            elif (sub in number):
                lexeme.append(sub)
                token.append("Number")
                tokenvalues.append("C "+str(sub))

            elif (sub[0]==double[0] and sub[x-1]==double[0]):
                lexeme.append(sub)
                token.append("String Constant")
                tokenvalues.append("C "+sub)

            elif (isValid(sub) == True and isDelim(line[right - 1])== False):
                #for the . 
                if "." in sub:
                    sp=sub.split(".")
                    for i in range(0,len(sp)):
                        lexeme.append(sp[i])
                        token.append("Identifier")
                        tokenvalues.append("ID ")

                    
                    if ispresent(sp):
                        for i in range(0,len(sp)):
                            if ispresent(sp[i]):
                                symbols.append(sp[i])
                                # symbolline.append(sycounter)
                                # sycounter=sycounter+1
                        
                        
                    
                     
                else:
                    lexeme.append(sub)
                    if ispresent(sub):
                        symbols.append(sub)
                        # symbolline.append(sycounter)
                        # sycounter=sycounter+1
                    token.append("Identifier")
                    tokenvalues.append("ID ")
                

            elif (isValid(sub) == False and isDelim(line[right - 1])== False):
                lexeme.append(sub)
                token.append("Invalid Identifier")

            left = right
        
# global sycounter
# sycounter=1
for i in range(len(lines)):
    parser(lines[i],i)

for i in range(0,len(symbols)):
    symbolline.append(i+1)

#*****************************************************
for i in range(0,len(symbols)):
    for j in range(0,len(lexeme)):
        if(lexeme[j]==symbols[i]):
            toc="ID "+str(symbolline[i])
            tokenvalues[j]=toc



# df = pd.DataFrame(list(zip(line_num,lexeme, token)),
# columns=["Line Nummber", "Lexeme", "Token"])
# import numpy as np
# df.replace(' ', np.nan, inplace=True)
# df.dropna(inplace=True)
# print(tabulate(df, headers="keys",tablefmt="grid"))



df = pd.DataFrame(list(zip(line_num,lexeme, token,tokenvalues)),
columns=["Line Number", "Lexeme", "Token","Token Values"])
import numpy as np
df.replace(' ', np.nan, inplace=True)
df.dropna(inplace=True)
print(tabulate(df, headers="keys",tablefmt="grid"))


print("**************************Symbol  table*********************")


df2 = pd.DataFrame(list(zip(symbolline,symbols)),
columns=["Index Number","Symbol Name"])
import numpy as np
df.replace(' ', np.nan, inplace=True)
df.dropna(inplace=True)
print(tabulate(df2, headers="keys",tablefmt="grid"))


# print("**************************TOKEN VALUES*********************")
# for i in range(0,len(tokenvalues)):
#     print(tokenvalues[i])






