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
void countMultLineToken();

 /* TODO: function to process a string literal */
int processString();

%}

newline         [\r]?[\n]
whitespace      [ \t]+
integer        	0|[1-9][0-9]*
integerlead0    0[0-9]+
character       '[^\n]|.'

 /* String can contain any characters between the double quotes */
 /* other than a newline or unescaped doublequotes */
string        \"([^\n"]|\\.)*\"


/* If the end quote is not found in the same line the string is unterminated */

untermstring \"([^\"\n\\]|\\.)*\n

comment         \/\/([^\n])*
multlncomment   \/\*(.|\n)*\*\/
untermcomment   \/\*(.|\n)*

identifier      [a-zA-Z]([a-zA-Z0-9])*
illidentifier   [0-9]([a-zA-Z0-9])*

yylineno = 1;

%%

 /* rules */

 /* Keywords */
 /* TODO: Support all keywords in mC */

"if" {updateCol(); return KWD_IF;}
"else" {updateCol(); return KWD_ELSE;}
"while" {updateCol(); return KWD_WHILE;}
"int" {updateCol(); return KWD_INT;}
"string" {updateCol(); return KWD_STRING;}
"char" {updateCol(); return KWD_CHAR;}
"return" {updateCol(); return KWD_RETURN;}
"void" {updateCol(); return KWD_VOID;}

 /* Operators */
 /* TODO: Support all operators in mC */

"+" {updateCol(); return OPER_ADD;}
"-" {updateCol(); return OPER_SUB;}
"*" {updateCol(); return OPER_MUL;}
"/" {updateCol(); return OPER_DIV;}
"<" {updateCol(); return OPER_LT;}
">" {updateCol(); return OPER_GT;}
">=" {updateCol(); return OPER_GTE;}
"<=" {updateCol(); return OPER_LTE;}
"==" {updateCol(); return OPER_EQ;}
"!=" {updateCol(); return OPER_NEQ;}
"=" {updateCol(); return OPER_ASGN;}
"@" {updateCol(); return OPER_AT;}
"++" {updateCol(); return OPER_INC;}
"--" {updateCol(); return OPER_DEC;}
"&&" {updateCol(); return OPER_AND;}
"||" {updateCol(); return OPER_OR;}

 /* FINISH OPERATORS */

 /* Identifiers */;
{identifier}  {updateCol(); return ID;}  
{illidentifier} {updateCol(); yyerror = "Illegal token"; return ERROR;}

 /* Constants */;
{integer}       {updateCol(); return INTCONST;}
{integerlead0}  {updateCol(); yyerror = "Illegal token"; return ERROR;}
{character}     //TODO
{string}        {updateCol(); return processString();}
{untermstring}  {updateCol(); yyerror = "Unterminated string"; return ERROR;}

 /* Comments */
{comment}       {updateCol();}
{untermcomment} {updateCol(); yyerror = "Unterminated comment"; return ERROR;}
{multlncomment} {countLine(); updateCol();}

 /* Other */
{newline}       {countLines();}
{whitespace}    {updateCol();}
.               {return ILLEGAL_TOK;}

%%

/* user routines */

/* TODO:
Implement this function to keep track of column numbers
*/
void updateCol(){
    yycol = scancol;
    ++scancol;
}

/* TODO:
Implement this function to keep track of line numbers
*/
void countLines(){
    yycol=scancol;
    scancol = 1;
    ++yylineno;
}

void countMultLineToken(){
    for(int i = 0; i < yyleng; i++){
        
    }
}

/* TODO: 
Implement this function to
check for illegal escape sequences in string literals
and
convert valid escape sequences into escaped characters
(string[0] == '\\' and string[1] == 'n', then string[0] should be '\n')
*/
int processString(){
    return 0;
}
