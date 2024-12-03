/** I pledge to Honor that I have not cheated, and will not cheat, on this assignment. - Logan Kelsch **/
/* Logan Kelsch */
/* COSC 362 */
/* Project 1 */
/* 10/9-10/24 */

/* Most copied and structured from dism.l */
%option yylineno
%option noyywrap
/* switched debug to 1 as instructed */
%{
  #define DEBUG 1
  typedef YYTOKENTYPE Token;
  Token scanned(Token t);
%}
/* whitespace changed to remove \n */
digit   [0-9]
label   [a-zA-Z][a-zA-z0-9]*
wspace  [ \t\r]+
%%
    /* characters */
":="    {return scanned(ASSIGN);}
"="     {return scanned(EQ);}
"<"     {return scanned(LT);}
"+"     {return scanned(PLUS);}
"-"     {return scanned(MINUS);}
"*"		{return scanned(TIMES);}
">"     {return scanned(OVER);}
"("     {return scanned(LPAREN);}
")"     {return scanned(RPAREN);}
";"		{return scanned(SEMI);}
"{"     { char c = input(); /*checking for } and not EOF */
            while(c!='}' && c!=EOF) c=input();
        }
"\n"	{printf("\n"); }
    /* reserve */
error   {return scanned(ERROR);}
read    {return scanned(READ);}
write   {return scanned(WRITE);}
end     {return scanned(END);}
repeat  {return scanned(REPEAT);}
until   {return scanned(UNTIL);}
if      {return scanned(IF);}
then    {return scanned(THEN);}
else    {return scanned(ELSE);}
{digit} {return scanned(NUM);}
{label} {return scanned(ID);}
{wspace}    { /*skip whitespace*/ }
<<EOF>>     {return scanned(ENDFILE);}
.           {if(DEBUG) printf("\n");
            printf("Lex error on line %d: Illegal character %s\n",
                yylineno,yytext);
            exit(-1);
            }
%%
/* copied this exact same general structure from dism.l */
/* process and return scanned token t */
Token scanned(Token t) {
  if(DEBUG==0) return t;
  switch(t) {
    /* characters */
    case ASSIGN: printf("ASSIGN "); return t;
    case EQ: printf("EQ "); return t;
    case LT: printf("LT "); return t;
    case PLUS: printf("PLUS "); return t;
    case MINUS: printf("MINUS "); return t;
    case TIMES: printf("TIMES "); return t;
    case OVER: printf("OVER "); return t;
    case LPAREN: printf("LPAREN "); return t;
    case RPAREN: printf("RPAREN "); return t;
    case SEMI: printf("SEMI "); return t;
    /* reserve */
    case ERROR: printf("ERROR "); return t;
    case IF: printf("IF "); return t;
    case THEN: printf("THEN "); return t;
    case ELSE: printf("ELSE "); return t;
    case END: printf("END "); return t;
    case REPEAT: printf("REPEAT "); return t;
    case UNTIL: printf("UNTIL "); return t;
    case READ: printf("READ "); return t;
    case WRITE: printf("WRITE "); return t;
    case NUM: printf("NUM(%s) ", yytext); return t;
    case ID: printf("ID(%s) ", yytext); return t;
    /* EOF */
    case ENDFILE: printf("ENDOFFILE\n"); exit(-1);
    default: printf("ERROR: invalid token in scanned().\n"); exit(-1);
  }
}

