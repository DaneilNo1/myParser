%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}

%token T_CHAR T_INT T_STRING T_BOOL T_VOID

%token SEMICOLON

%token LOP_ASSIGN LOP_ADDTO LOP_MINTO LOP_MULTO LOP_DIVTO

%token IDENTIFIER INTEGER CHAR BOOL STRING VOID CONST

%token IF ELSE FOR WHILE BREAK CONTINUE RETURN

%token TRUE FALSE

%token ADD MINUS MUL DIV MOD

%token NOT AND OR

%token BITAND BITOR BITNOT SHL SHR

%token LS GT EQ LE GE NE

%token COMMA

%token LBRACE RBRACE LPAREN RPAREN

%left LOP_EQ


%%

CompUnit
: Decl {$$->addChild($1);}
| FuncDef {$$->addChild($1);}
| CompUnit Decl 
| CompUnit FuncDef
;

Decl
: ConstDecl {cout<<"ConstDecl"<<endl;}
| VarDecl {cout<<"VarDecl"<<endl;}
;

ConstDecl
: CONST BType ConstDefs SEMICOLON
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
: IDENTIFIER LOP_ASSIGN ConstInitVal
| IDENTIFIER ArrayIndexs LOP_ASSIGN ConstInitVal
;

ArrayIndexs
: ArrayIndex
| ArrayIndexs ArrayIndex
;

ArrayIndex
: '[' ConstExp ']'
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
: VarDef
| VarDefs COMMA VarDef
;

VarDef
: IDENTIFIER
| IDENTIFIER ArrayIndexs
| IDENTIFIER LOP_ASSIGN InitVal
| IDENTIFIER ArrayIndexs LOP_ASSIGN InitVal
;

InitVals
: InitVal
| InitVals COMMA InitVal
;

InitVal
: ConstExp
| LBRACE RBRACE
| LBRACE InitVals RBRACE
;

FuncDef
: BType IDENTIFIER LPAREN RPAREN Block
| T_VOID IDENTIFIER LPAREN RPAREN Block
| BType IDENTIFIER LPAREN FuncFParams RPAREN Block
| T_VOID IDENTIFIER LPAREN FuncFParams RPAREN Block
;

FuncFParams
: FuncFParam
| FuncFParams COMMA FuncFParam
;

FuncFParam
: BType IDENTIFIER
| BType IDENTIFIER '[' ']'
| BType IDENTIFIER '[' ']' ArrayIndexs
;

Block
: LBRACE BlockItems RBRACE
| LBRACE RBRACE
;

BlockItems
: BlockItem
| BlockItems BlockItem
;

BlockItem
: Decl
| Stmt
;

Stmt
: LVal LOP_ASSIGN ConstExp SEMICOLON
| SEMICOLON
| ConstExp SEMICOLON
| Block
| IF LPAREN Cond RPAREN Stmt {cout<<"if"<<endl;}
| IF LPAREN Cond RPAREN Stmt ELSE Stmt
| WHILE LPAREN Cond RPAREN Stmt {cout<<"while"<<endl;}
| BREAK SEMICOLON
| CONTINUE SEMICOLON
| RETURN SEMICOLON
| RETURN ConstExp SEMICOLON
;

Cond
: LOrExp {cout<<"LOrExp"<<endl;}
;

LVal
: IDENTIFIER
| IDENTIFIER ArrayIndexs
;

PrimaryExp
: LPAREN ConstExp RPAREN
| LVal
| Number
;

Number
: INTEGER {cout<<"INTEGER"<<endl;}
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
: ConstExp
| FuncRParams COMMA ConstExp
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
