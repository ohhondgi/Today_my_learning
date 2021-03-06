%token KW_LET KW_FUN KW_IN 
%token LSPAREN RSPAREN 
%token OP_RARROW OP_PLUS OP_MINUS OP_EQ
%token <string> ID
%token <int> NUMBER
%token EOF 
%nonassoc low
%left OP_PLUS OP_MINUS
%left LSPAREN NUMBER ID
%type <Ast.fvae> main
%start main
%%

main:
  expr EOF { Ast.Prog $1 }
  ;
expr: 
  | KW_LET ID OP_EQ expr KW_IN expr %prec low { Ast.LetIn ($2, $4, $6) }
  | KW_LET ID id_list OP_EQ expr KW_IN expr %prec low { 
      let rec f = function
        | [] -> failwith "[Err] Wrong grammar"
        | [x] -> Ast.Fun (x, $5)
        | h :: t -> Ast.Fun (h, f t)
      in
      Ast.LetIn ($2, f $3, $7)
    }
  | term { $1 }
  | expr term { Ast.App ($1, $2) }
  | expr OP_PLUS term { Ast.Add ($1, $3) }
  | expr OP_MINUS term { Ast.Sub ($1, $3) }
  ;
term:
  | LSPAREN expr RSPAREN { $2 }
  | NUMBER { Ast.Num $1 }
  | ID { Ast.Id $1 }
  | LSPAREN KW_FUN id_list OP_RARROW expr RSPAREN { 
      let rec f = function
        | [] -> failwith "[Err] Wrong grammar"
        | [x] -> Ast.Fun (x, $5)
        | h :: t -> Ast.Fun (h, f t)
      in
      f $3
    }
  ;
id_list:
  | ID { [$1] }
  | ID id_list { $1 :: $2 }
