%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno=1;
int otod(string oct);
int htod(string hex);
%}
BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

DEC_CONST   [1-9][0-9]*
OCT_CONST   0[0-7]*
HEX_CONST   (0X|0x)[0-9a-fA-F]*
INTEGER ([1-9][0-9]*)|(0[0-7]*)|((0x|0X)([0-9A-Fa-f]*))

CHAR \'.?\'
STRING \".+\"

IDENTIFIER [[:alpha:]_][[:alpha:][:digit:]_]*
%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */


"int" return T_INT;
"bool" return T_BOOL;
"char" return T_CHAR;
"void"  return T_VOID;

"if"	return IF;
"else"	return ELSE;
"while"	return WHILE;
"break" return BREAK;
"continue"  return CONTINUE;
"return"    return RETURN;

"const" return CONST;

"true"  return TRUE;
"false" return FALSE;


"=" return LOP_ASSIGN;
"+="    return LOP_ADDTO;
"-="    return LOP_MINTO;
"*="    return LOP_MULTO;
"/="    return LOP_DIVTO;

";" return  SEMICOLON;

"(" return LPAREN;
")" return RPAREN;
"{" return LBRACE;
"}" return RBRACE;
"[" return LS_LBRA;
"]" return LS_RBRA;

"+" return ADD;
"-" return MINUS;
"*" return MUL;
"/" return DIV;
"%" return MOD;

"!" return NOT;
"&&"    return AND;
"||"    return OR;

"&" return BITAND;
"|" return BITOR;
"~" return BITNOT;
"<<"    return SHL;
">>"    return SHR;

"<" return LS;
">" return GT;
"=="    return EQ;
"<="    return LE;
">="    return GE;
"!="    return NE;

"," return COMMA;


{DEC_CONST} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return DEC_CONST;
}

{OCT_CONST} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = otod(yytext);
    yylval = node;
    return OCT_CONST;
}

{HEX_CONST} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = htod(yytext);
    yylval = node;
    return HEX_CONST;
}

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}

{IDENTIFIER} {
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return IDENTIFIER;
}

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%

int otod(string oct){
    int res = 0;
    for(int i = 1;i < oct.length();i++){
        res *= 8;
        res += oct[i] - '0';
    }
    return res;
}

int htod(string hex){
    int res = 0;
    for(int i = 2; i < hex.length();i++){
        res *= 16;
        switch (hex[i]){
            case 'a'||'A': res += 10;break;
            case 'b'||'B': res += 11;break;
            case 'c'||'C': res += 12;break;
            case 'd'||'D': res += 13;break;
            case 'e'||'E': res += 14;break;
            case 'f'||'F': res += 15;break;
            default: res += hex[i] - '0';
        }
    }
}