{
  open Parse

  exception Error of string
}


rule token = parse
| [' ' '\t'] (* also ignore newlines, not only whitespace and tabs *)
    { token lexbuf }
| '\n' { NEWLINE }
| '+'
    { PLUS }
| '-'
    { MINUS }
| '*'
    { TIMES }
| '^'
    { EXP }
| '/'
    { DIV }
| '('
    { LPAREN }
| ')'
    { RPAREN }
| "log"
    { LOG }
| "sin"
    { SIN }
| "cos"
    { COS }
| "tan"
    { TAN }
| "print"
    { PRINT }
| ['0'-'9']+ as i
    { NUMBER (float_of_string i) }
| ['0'-'9']*['.']['0'-'9']+ as i
    { NUMBER (float_of_string i)}
| ['0'-'9']*['.']['0'-'9']*['e']['0'-'9']+ as i
    { NUMBER (float_of_string i)}
| ['a'-'z']['a'-'z''_''0'-'9']+ as i
    { VAR i }
| eof
    { EOF }
| _
    { raise (Error (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }
