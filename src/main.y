%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}

%token T_CHAR T_INT T_STRING T_BOOL T_VOID

%token LOP_ASSIGN LOP_ADDTO LOP_MINTO LOP_MULTO LOP_DIVTO

%token IDENTIFIER INTEGER CHAR BOOL STRING VOID CONST

%token IF ELSE FOR WHILE BREAK CONTINUE RETURN

%token TRUE FALSE

%token ADD MINUS MUL DIV MOD

%token NOT AND OR

%token BITAND BITOR BITNOT SHL SHR

%token LS GT EQ LE GE NE

%token COMMA



%left LOP_EQ


%%

CompUnit
: Decl 
| FuncDef
| CompUnit Decl
| CompUnit FuncDef
;

Decl
: ConstDecl
| VarDecl
;

ConstDecl
: CONST BType ConstDefs ';'
;

BType
: T_INT
| T_CHAR
| T_STRING
;

ConstDefs
: ConstDef
| ConstDefs COMMA ConstDef
;

ConstDef
: IDENTIFIER ArrayIndexs LOP_ASSIGN ConstInitVal
;

ArrayIndexs
: ArrayIndexs ArrayIndex
|
;

ArrayIndex
: LS_LBRA ConstExp LS_RBRA
;

ConstInitVals
: ConstInitVal
| ConstInitVals COMMA ConstInitVal
;

ConstInitVal
: ConstExp
| LBRACE RBRACE
| LBRACE ConstInitVals RBRACE
;


VarDecl
: BType VarDefs SEMICOLON
;

VarDefs
: VarDef ArrayIndexs
| VarDefs ArrayIndexs COMMA VarDef
;

VarDef
: IDENTIFIER
| IDENTIFIER LOP_ASSIGN InitVal
;

InitVals
: InitVal
| InitVals COMMA InitVal
;

InitVal
: Exp
| LBRACE RBRACE
| LBRACE InitVals RBRACE
;

FuncDef
: FuncType IDENTIFIER LPAREN RPAREN Block
| FuncType IDENTIFIER LPAREN FuncFParams RPAREN Block
;

FuncType
: T_INT
| T_CHAR
| T_STRING
| T_VOID
;

FuncFParams
: FuncFParam
| FuncFParams COMMA FuncFParam
;

FuncFParam
: BType IDENTIFIER
| BType IDENTIFIER MultipuleIndexs
;

MultipuleIndexs
: LS_LBRA LS_RBRA
| LS_LBRA LS_RBRA DynamicIndex
;

DynamicIndex
: LS_LBRA Exp LS_RBRA
| DynamicIndex LS_LBRA Exp LS_RBRA
;

Block
: LBRACE BlockItems RBRACE
;

BlockItems
: BlockItems BlockItem
|
;

BlockItem
: Decl
| Stmt
;

Stmt
: LVal LOP_ASSIGN Exp SEMICOLON
| SEMICOLON
| Exp SEMICOLON
| Block
| IF LPAREN Cond RPAREN Stmt
| IF LPAREN Cond RPAREN Stmt ELSE Stmt
| WHILE LPAREN Cond RPAREN Stmt
| BREAK SEMICOLON
| CONTINUE SEMICOLON
| RETURN SEMICOLON
| RETURN Exp SEMICOLON
;

Exp
: AddExp
;

Cond
: LOrExp
;

LVal
: IDENTIFIER DynamicIndex
;

PrimaryExp
: LPAREN Exp RPAREN
| LVal
| Number
;

Number
: INTEGER
;

UnaryExp
: PrimaryExp 
| IDENTIFIER LPAREN RPAREN
| IDENTIFIER LPAREN FuncRParams RPAREN
| UnaryOp UnaryExp
;

UnaryOp
: ADD
| MINUS
| NOT
;

FuncRParams
: Exp
| FuncRParams COMMA Exp
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


%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}
