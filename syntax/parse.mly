%{ open Ast %}

%token <float> NUMBER
%token PRINT NEWLINE
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token EXP
%token LPAREN
%token RPAREN
%token COS
%token SIN
%token TAN
%token LOG
%token <float> NEGATE
%token <string> VAR
%token PRINT
%token EOF

%start <stmt list> main

%%

main:
| s = stmt NEWLINE rest = main
    { s :: rest }
| s = stmt EOF
  { [s] }
| EOF
  { [] }

stmt:
| PRINT e = expr1
  { Print e }
| NEGATE e1 = expr1
  { Negate (e1) }

expr1:
| e1 = expr1 PLUS e2 = expr0
  { Plus (e1, e2) }
| e1 = expr1 MINUS e2 = expr0
  { Minus (e1, e2) }
| e1 = expr1 TIMES e2 = expr0
  { Times (e1, e2) }
| e1 = expr0 EXP e2 = expr1
  { Exp (e1, e2) }
| e1 = expr1 DIV e2 = expr0
  { Divide (e1, e2) }
| e = expr0 { e }

expr0:
| n = NUMBER
  { Num n }
