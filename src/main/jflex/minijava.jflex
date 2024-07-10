/*
 * JFlex specification for MiniJava.
 * by David Kimura and David Koenig
 *
 * from https://github.com/dgkimura/MiniJava/blob/master/src/Scanner/minijava.jflex
 */


package Scanner;

import java_cup.runtime.*;
import Parser.sym;
import Throwables.*;

%%

%public
%final
%class scanner
%yylexthrow CompilerException
%unicode
%cup
%line
%column

%{
  // note that these Symbol constructors are abusing the Symbol
  // interface to use Symbol's left and right fields as line and column
  // fields instead
  private Symbol symbol(int type) {
    return new Symbol(type, yyline+1, yycolumn+1);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline+1, yycolumn+1, value);
  }

  // print out a symbol (aka token) nicely
  public String symbolToString(Symbol s) {
    	if (s.value!=null) {
    		return (sym.terminalNames[s.sym]+"("+s.value+")");
    	}
    	else {
    		return (sym.terminalNames[s.sym]);
    	}	
  }
%}

/* Helper definitions */
letter = [a-zA-Z]
digit = [0-9]
eol = [\r\n]
not_eol = [^\r\n]
white = {eol}|[ \t]

/* C89-style comments */
start_comment = "/*"
comment_contents = ([^*]|\*[^/])
end_comment = "*/"

%%

/* Token definitions */

/* comments */
"//"{not_eol}*{eol} { /* do nothing */ }
{start_comment}{comment_contents}*{end_comment} { /* do nothing */ }

/* reserved words */
/* (put here so that reserved words take precedence over identifiers) */

/* types */
"boolean" { return symbol(sym.BOOLEAN_TYPE); }
"int" { return symbol(sym.INTEGER_TYPE); }
"true" { return symbol(sym.TRUE); }
"false" { return symbol(sym.FALSE); }
"String" { return symbol(sym.STRING); }

/* control flow */
"if" { return symbol(sym.IF); }
"else" { return symbol(sym.ELSE); }
"while" { return symbol(sym.WHILE); }
"return" { return symbol(sym.RETURN); }
"System"{white}*"."{white}*"out"{white}*"."{white}*"println" {
    return symbol(sym.SYSTEM_OUT_PRINTLN);
}

/* declarations */
"class" { return symbol(sym.CLASS); }
"extends" { return symbol(sym.EXTENDS); }
"public" { return symbol(sym.PUBLIC); }
"protected" { return symbol(sym.PROTECTED); }
"private" { return symbol(sym.PRIVATE); }
"static" { return symbol(sym.STATIC); }
"void" { return symbol(sym.VOID); }
"main" { return symbol(sym.MAIN); }

"length" { return symbol(sym.LENGTH); }
"this" { return symbol(sym.THIS); }
"new" { return symbol(sym.NEW); }

/* literals */
{digit}+ { return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }

/* operators */
"+" { return symbol(sym.PLUS); }
"-" { return symbol(sym.MINUS); }
"*" { return symbol(sym.TIMES); }
"&&" { return symbol(sym.AND); }
"<" { return symbol(sym.LT); }
">" { return symbol(sym.GT); }
">=" { return symbol(sym.GE); }
"<=" { return symbol(sym.LE); }
"==" { return symbol(sym.EQUALS); }
"/" { return symbol(sym.DIVIDE); }
"!" { return symbol(sym.NOT); }
"." { return symbol(sym.DOT); }
"," { return symbol(sym.COMMA); }

"=" { return symbol(sym.BECOMES); }

/* delimiters */
"(" { return symbol(sym.LPAREN); }
")" { return symbol(sym.RPAREN); }
"[" { return symbol(sym.LBRACKET); }
"]" { return symbol(sym.RBRACKET); }
"{" { return symbol(sym.LBRACE); }
"}" { return symbol(sym.RBRACE); }
";" { return symbol(sym.SEMICOLON); }

/* identifiers */
{letter} ({letter}|{digit}|_)* { return symbol(sym.IDENTIFIER, yytext()); }


/* whitespace */
{white}+ { /* ignore whitespace */ }

/* lexical errors (put last so other matches take precedence) */
. {
    System.err.println(
        "Warning: ignoring invalid token at line " +
        (yyline + 1) +
        ", column " +
        (yycolumn + 1) +
        "."
    );

    // Do not return any tokens
}
