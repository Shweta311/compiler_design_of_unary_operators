%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int line=0;
%}

%union {
    int ival;
}

%token <ival> NUMBER
%type <ival> expression
%token INCREMENT DECREMENT MINUS NOT ADDRESSOF SIZEOF LPAREN RPAREN SEMICOLON

%%


program:
    expression { printf("OUTPUT: %d\n", $1); }

expression:
    INCREMENT expression SEMICOLON {generateIntermediateCodeForInc($2); $$ = $2 + 1; }
    | DECREMENT expression SEMICOLON {generateIntermediateCodeForDec($2);$$ = $2 - 1; }
    | MINUS expression SEMICOLON {generateIntermediateCodeForMinus($2); $$ = -$2; }
    | NOT expression SEMICOLON {generateIntermediateCodeForNot($2); $$ = !$2; }
    | ADDRESSOF expression SEMICOLON {generateIntermediateCodeForAddressOf($2); $$ = &$2; }
    | SIZEOF LPAREN expression RPAREN SEMICOLON {generateIntermediateCodeForSizeOf($3); $$ = sizeof($3); }
    | NUMBER { $$ = $1; }
    | expression INCREMENT SEMICOLON {generateIntermediateCodeForInc1($1); $$ = $1 + 1; }
    | expression DECREMENT SEMICOLON {generateIntermediateCodeForDec1($1); $$ = $1 - 1; }

%%

void generateIntermediateCodeForInc(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = %d\n",++line,var1);
  printf("L%d\t:\tT2 = T1 + 1\n",++line);

}
void generateIntermediateCodeForInc1(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = %d\n",++line,var1);
  printf("L%d\t:\tT2 = T1 + 1\n",++line);
  // printf("L%d\t:\tT3 = %d\n",++line,var1+1);

}
void generateIntermediateCodeForDec(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = %d\n",++line,var1);
  printf("L%d\t:\tT2 = T1 - 1\n",++line);

}
void generateIntermediateCodeForDec1(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = %d\n",++line,var1);
  printf("L%d\t:\tT2 = T1 - 1\n",++line);
  // printf("L%d\t:\tT3 = %d\n",++line,var1-1);

}
void generateIntermediateCodeForMinus(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = -%d\n",++line,var1);

}

void generateIntermediateCodeForNot(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = !%d\n",++line,var1);

}

void generateIntermediateCodeForAddressOf(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = &%d\n",++line,var1);

}
void generateIntermediateCodeForSizeOf(int var1){

  printf("\nIntermediate Code:\n");
  printf("L%d\t:\tT1 = sizeof(%d)\n",++line,var1);

}

int main(int argc, char *argv[]) {
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}