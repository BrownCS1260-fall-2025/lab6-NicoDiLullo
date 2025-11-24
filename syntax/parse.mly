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
%token EQ
%token <float> NEGATE
%token <string> VAR
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
| name=VAR EQ e = expr1
  {Assign (name, e)}

expr1:
| LPAREN e1 = expr1 RPAREN
  { e1 }
| NEGATE e1 = expr1
  { Negate (e1) }
| LOG e1 = expr1
  { Log (e1) }
| COS e1 = expr1
  { Cos (e1) }
| SIN e1 = expr1
  { Sin (e1) }
| TAN e1 = expr1
  { Tan (e1) }
| e1 = expr0 EXP e2 = expr1
  { Exp (e1, e2) }
| e1 = expr1 TIMES e2 = expr0
  { Times (e1, e2) }
| e1 = expr1 DIV e2 = expr0
  { Divide (e1, e2) }
| e1 = expr1 PLUS e2 = expr0
  { Plus (e1, e2) }
| e1 = expr1 MINUS e2 = expr0
  { Minus (e1, e2) }
| e = expr0 { e }

expr0:
| n = NUMBER
  { Num n }
| name = VAR
  {Var name}
