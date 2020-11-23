%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}
%token T_CHAR T_INT T_STRING T_BOOL 

%token LOP_ASSIGN

%token SEMICOLON

%token IDENTIFIER INTEGER CHAR BOOL STRING VOID

%left LOP_EQ

%%


CompUnit
: Decl 
| FuncDef
;

Decl
: ConstDecl
| VarDecl
;

ConstDecl
: CONST BType ConstDef SEMICOLON
;

BType
: T_INT
| T_CHAR
| T_STRING
;

ConstDef
: IDENTIFIER LOP_ASSIGN ConstInitVal
;

ConstInitVal
: ConstExp
| LBRACE RBRACE
;


VarDecl
: BType VarDef SEMICOLON
;

VarDef
: IDENTIFIER
| IDENTIFIER LOP_ASSIGN InitVal
;

InitVal
: Exp
| LBRACE RBRACE
;

FuncDef
: FuncType IDENTIFIER LPAREN RPAREN Block
;

FuncType
: T_INT
| T_CHAR
| T_STRING
| T_VOID
;

FuncFParams
: FuncFParam
;

FuncFParam
: BType IDENTIFIER
;

Block
: LBRACE RBRACE
;

BlockItem
: Decl
| Stmt
;

Stmt
: LVal LOP_ASSIGN Exp SEMICOLON
| SEMICOLON
| Block
| IF LPAREN Cond RPAREN Stmt
| WHILE LPAREN Cond RPAREN Stmt
| BREAK SEMICOLON
| CONTINUE SEMICOLON
| RETURN SEMICOLON
;

Exp
: AddExp
;

Cond
: LOrExp
;

LVal
: IDENTIFIER 
;

PrimaryExp
: LPAREN Exp RPAREN
| LVal
| Number
;

Number
: DEC_CONST
| OCT_CONST
| HEX_CONST
;

UnaryExp
: PrimaryExp 
| IDENTIFIER LPAREN RPAREN
| UnaryOp UnaryExp
;

UnaryOp
: ADD
| MINUS
| NOT
;

FuncRParams
: Exp
;

MulExp
: UnaryExp
| MulExp MUL UnaryExp
| MulExp DIV UnaryExp
| MulExp MOD UnaryExp
;

AddExp
: MulExp 
| AddExp ADD MulExp
| AddExp MINUS MulExp
;

RelExp
: AddExp 
| RelExp LS AddExp
| RelExp GT AddExp
| RelExp LE AddExp
| RelExp GE AddExp
;

EqExp
: RelExp
| EqExp EQ RelExp
| EqExp NE RelExp
;

LAndExp
: EqExp 
| LAndExp AND EqExp
;

LOrExp
: LAndExp 
| LOrExp OR LAndExp
;

ConstExp
: AddExp
;














































program
: statements {root = new TreeNode(0, NODE_PROG); root->addChild($1);};

statements
:  statement {$$=$1;}
|  statements statement {$$=$1; $$->addSibling($2);}
;

statement
: SEMICOLON  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMICOLON {$$ = $1;}
;

declaration
: T IDENTIFIER LOP_ASSIGN expr{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;
} 
| T IDENTIFIER {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;
}
;

expr
: IDENTIFIER {
    $$ = $1;
}
| INTEGER {
    $$ = $1;
}
| CHAR {
    $$ = $1;
}
| STRING {
    $$ = $1;
}
;

T: T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;}
| T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
| T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
;



%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}
