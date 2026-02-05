
/* definitions */

%{
#include<stdio.h>
#include "tokendef.h"

int scancol = 1;
int yycol = 1;
int scanlineno = 1;

char* yyerror;

void updateCol(); //TODO: Implement this function to keep track of column numbers
void countLines(); //TODO: Implement this function to keep track of line numbers
int processString(); //TODO: Implement this function to check for illegal escape sequences in string literals and print out escape sequences correctly.
%}

newline         \n
whitespace      [ \t\r\n]+
integer        	0 | [1-9][0-9]*
character       '[^'\n]'

/* String can contain any characters between the double quotes other than a newline or
// unescaped doublequotes.
*/
string       //TODO

/* multiline string has \n somewhere in the middle */
multlnstring //TODO

/* If the end quote is found, one of the two regexes above will be matched. Otherwise,
// the string is unterminated.
*/
untermstring //TODO

comment         //TODO
multlncomment   //TODO
untermcomment   //TODO

identifier      //TODO
illidentifier   //TODO: regular expression for an illegal identifier

yylineno = 1;

%%

 /* rules */

 /* Keywords */;
"if" {return KWD_IF;}
"else" {return KWD_ELSE;}
"while" {return KWD_WHILE;}
"int" {return KWD_INT;}
"string" {return KWD_STRING;}
"char" {return KWD_CHAR;}
"return" {return KWD_RETURN;}
"void" {return KWD_VOID;}
 /* Operators */;
"+" {return OPER_ADD;}
"-" {return OPER_SUB;}
"*" {return OPER_MUL;}
"/" {return OPER_DIV;}
"<" {return OPER_LT;}
">" {return OPER_GT;}
">=" {return OPER_GTE;}
"<=" {return OPER_LTE;}
"==" {return OPER_EQ;}
"!=" {return OPER_NEQ;}
"=" {return OPER_ASGN;}

 /* Identifiers */;
{identifier}    //TODO
{illidentifier} //TODO

 /* Constants */;
{integer}       //TODO
{integerlead0}  //TODO: "Integers may not have leading zeros"
{character}     //TODO
{string}        {updateCol(); return processString();}
{untermstring}  {updateCol(); yyerror = "Unterminated string"; return ERROR;}
{multlnstring}  {updateCol(); countLines(); yyerror = "String spans multiple lines"; return ERROR;} // Catching a multi-line string and generating an error.

 /* Comments */;
{comment}       //TODO
{untermcomment} //TODO
{multlncomment} //TODO

 /* Other */;
{newline}       //TODO
{whitespace}    //TODO
.               {return ILLEGAL_TOK;}

%%

/* user routines */

void updateCol(){
	//TODO: Keep track of column number
}

void countLines(){
	//TODO: Count the number of lines
}


int processString(){
	// TODO: Process a string literal and return the appropriate microsyntax.
}
