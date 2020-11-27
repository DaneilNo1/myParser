/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_SRC_MAIN_TAB_H_INCLUDED
# define YY_YY_SRC_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_CHAR = 258,
    T_INT = 259,
    T_STRING = 260,
    T_BOOL = 261,
    T_VOID = 262,
    LOP_ASSIGN = 263,
    LOP_ADDTO = 264,
    LOP_MINTO = 265,
    LOP_MULTO = 266,
    LOP_DIVTO = 267,
    SEMICOLON = 268,
    IDENTIFIER = 269,
    INTEGER = 270,
    CHAR = 271,
    BOOL = 272,
    STRING = 273,
    VOID = 274,
    CONST = 275,
    IF = 276,
    ELSE = 277,
    FOR = 278,
    WHILE = 279,
    BREAK = 280,
    CONTINUE = 281,
    RETURN = 282,
    TRUE = 283,
    FALSE = 284,
    LPAREN = 285,
    RPAREN = 286,
    LBRACE = 287,
    RBRACE = 288,
    LS_LBRA = 289,
    LS_RBRA = 290,
    ADD = 291,
    MINUS = 292,
    MUL = 293,
    DIV = 294,
    MOD = 295,
    NOT = 296,
    AND = 297,
    OR = 298,
    BITAND = 299,
    BITOR = 300,
    BITNOT = 301,
    SHL = 302,
    SHR = 303,
    LS = 304,
    GT = 305,
    EQ = 306,
    LE = 307,
    GE = 308,
    NE = 309,
    COMMA = 310,
    LOP_EQ = 311
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_MAIN_TAB_H_INCLUDED  */
