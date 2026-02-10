/* definitions */

%{
#include <stdio.h>
#include <stdlib.h>
#include "tokendef.h"

 /* integers to track line and column numbers */
int scancol = 1;
int yycol = 1;
int scanlineno = 1;

 /* char pointer to pass error messages to driver.c */
char *yyerror;

 /* TODO: functions to update line and column numbers */
void updateCol();
void countLines();

 /* TODO: function to process a string literal */
int processString();

%}

newline         \n
whitespace      [ \t\r\n]+
integer        	0|[1-9][0-9]*
integerlead0    0[0-9]+
character       '[^'\n]'

 /* String can contain any characters between the double quotes */
 /* other than a newline or unescaped doublequotes */
string        \"([^\n"]|\\.)*\"




comment         \/\/([^\n])*
multlncomment   \/\*(.|\n)*\*\/
untermcomment   //TODO

identifier      //TODO
illidentifier   //TODO: regular expression for an illegal identifier

yylineno = 1;

%%

 /* rules */

 /* Keywords */
 /* TODO: Support all keywords in mC */

"if" {return KWD_IF;}
"else" {return KWD_ELSE;}
"while" {return KWD_WHILE;}
"int" {return KWD_INT;}
"string" {return KWD_STRING;}
"char" {return KWD_CHAR;}
"return" {return KWD_RETURN;}
"void" {return KWD_VOID;}

 /* Operators */
 /* TODO: Support all operators in mC */

"+" {return OPER_ADD;}
"-" {return OPER_SUB;}
"*" {return OPER_MUL;}
"/" {return OPER_DIV;}
">=" {return OPER_GTE;}
"<=" {return OPER_LTE;}
"<" {return OPER_LT;}
">" {return OPER_GT;}
"==" {return OPER_EQ;}
"!=" {return OPER_NEQ;}
"=" {return OPER_ASGN;}
/* FINISH OPERATORS */

 /* Identifiers */;
{identifier}    //TODO
{illidentifier} //TODO

 /* Constants */;
{integer}       //TODO
{integerlead0}  //TODO: "Integers may not have leading zeros"
{character}     //TODO
{string}        {updateCol(); return processString();}
{untermstring}  {updateCol(); yyerror = "Unterminated string"; return ERROR;}

 /* Comments */
{comment}       //TODO
{untermcomment} //TODO
{multlncomment} //TODO

 /* Other */
{newline}       //TODO
{whitespace}    //TODO
.               {return ILLEGAL_TOK;}

%%

/* user routines */

/* TODO:
Implement this function to keep track of column numbers
*/
void updateCol(){
}

/* TODO:
Implement this function to keep track of line numbers
*/
void countLines(){
}

/* TODO: ?? DO THIS HELLO GIT
Implement this function to
check for illegal escape sequences in string literals
and
convert valid escape sequences into escaped characters
(string[0] == '\\' and string[1] == 'n', then string[0] should be '\n')
*/
int processString(){
    for(int i = 0; i < strlen(string); i++){
        
    }
}
