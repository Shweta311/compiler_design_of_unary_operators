%{
#include "parser.tab.h"
%}

%%

"++"           { return INCREMENT; }
"--"           { return DECREMENT; }
"-"            { return MINUS; }
"!"            { return NOT; }
"&"            { return ADDRESSOF; }
"sizeof"      { return SIZEOF; }
")"            { return RPAREN; }
"("            { return LPAREN; }
";"            { return SEMICOLON; }
[0-9]+         { yylval.ival = atoi(yytext); return NUMBER; }
[ \t\n]+       { /* ignore whitespace */ }
.              { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}