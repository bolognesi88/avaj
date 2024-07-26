package Scanner;

import java_cup.runtime.*;
import Parser.Java7Sym;
import Throwables.*;

%%

%public
%final
%class Java7Scanner
%yylexthrow CompilerException
%unicode
%cup
%line
%column

%{
 
  // aqui eu guardo a string sendo construida
  // veja http://www2.cs.tum.edu/projects/cup/examples.php
  StringBuffer string = new StringBuffer();
    
  // note that these Symbol constructors are abusing the Symbol
  // interface to use Symbol's left and right fields as line and column
  // fields instead
  
  // ATENCAO: é aqui que a mágica acontece de left e right carregarem linha e coluna !!!!!!!!!!!!!!!!
  
  private Symbol symbol(int type) {
    return new Symbol(type, yyline+1, yycolumn+1);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline+1, yycolumn+1, value);
  }

  // print out a symbol (aka token) nicely
  public String symbolToString(Symbol s) {
    	if (s.value!=null) {
    		return (Java7Sym.terminalNames[s.sym]+"("+s.value+")");
    	}
    	else {
    		return (Java7Sym.terminalNames[s.sym]);
    	}	
  }
%}

/* Helper definitions */
letter = [a-zA-Z]
digit = [0-9]
eol = [\r\n]
not_eol = [^\r\n]
white = {eol}|[ \t]

    /* comments from https://github.com/jflex-de/jflex/blob/master/docs/md/example.md */
    Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

    TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
    // Comment can be the last line of the file, without line terminator.
    EndOfLineComment     = "//" {not_eol}* {eol}?
    DocumentationComment = "/**" {CommentContent} "*"+ "/"
    CommentContent       = ( [^*] | \*+ [^/*] )*


	/* floating point literals */        
	FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
	DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?
	
	FLit1    = [0-9]+ \. [0-9]* 
	FLit2    = \. [0-9]+ 
	FLit3    = [0-9]+ 
	Exponent = [eE] [+-]? [0-9]+

%state STRING, CHARLITERAL

%%

<YYINITIAL> {
	
	
	/* Token definitions */
	
    /* comments */
    {Comment}                      { System.out.print("\n"+yytext());  /* ignore */ }
	
	
	/* reserved words */
	/* (put here so that reserved words take precedence over identifiers) */
	
	
	/* declarations */
	"package" { return symbol(Java7Sym.PACKAGE, yytext()); }
	"import" { return symbol(Java7Sym.IMPORT, yytext()); }
	"class" { return symbol(Java7Sym.CLASS, yytext()); }
	"enum" { return symbol(Java7Sym.ENUM, yytext()); }
	"interface" { return symbol(Java7Sym.INTERFACE, yytext()); }
	"extends" { return symbol(Java7Sym.EXTENDS, yytext()); }
	"implements" { return symbol(Java7Sym.IMPLEMENTS, yytext()); }
	"instanceof" { return symbol(Java7Sym.INSTANCEOF, yytext()); }
	
	
	/* types */
	"byte" { return symbol(Java7Sym.BYTE, yytext()); }
	"short" { return symbol(Java7Sym.SHORT, yytext()); }
	"char" { return symbol(Java7Sym.CHAR, yytext()); }
	"int" { return symbol(Java7Sym.INT, yytext()); }
	"long" { return symbol(Java7Sym.LONG, yytext()); }
	"float" { return symbol(Java7Sym.FLOAT, yytext()); }
	"double" { return symbol(Java7Sym.DOUBLE, yytext()); }
	"boolean" { return symbol(Java7Sym.BOOLEAN, yytext()); }
	
	
	"void" { return symbol(Java7Sym.VOID, yytext()); }
	"this" { return symbol(Java7Sym.THIS, yytext()); }
	"super" { return symbol(Java7Sym.SUPER, yytext()); }
	"new" { return symbol(Java7Sym.NEW, yytext()); }
	"true" { return symbol(Java7Sym.TRUE, yytext()); }
	"false" { return symbol(Java7Sym.FALSE, yytext()); }
	"null" { return symbol(Java7Sym.NULL, yytext()); }
	
	
	
	/* control flow */
	"if" { return symbol(Java7Sym.IF, yytext()); }
	"else" { return symbol(Java7Sym.ELSE, yytext()); }
	"for" { return symbol(Java7Sym.FOR, yytext()); }
	"while" { return symbol(Java7Sym.WHILE, yytext()); }
	"return" { return symbol(Java7Sym.RETURN, yytext()); }
	"do" { return symbol(Java7Sym.DO, yytext()); }
	"assert" { return symbol(Java7Sym.ASSERT, yytext()); }
	"switch" { return symbol(Java7Sym.SWITCH, yytext()); }
	"case" { return symbol(Java7Sym.CASE, yytext()); }
	"default" { return symbol(Java7Sym.DEFAULT, yytext()); }
	"break" { return symbol(Java7Sym.BREAK, yytext()); }
	"continue" { return symbol(Java7Sym.CONTINUE, yytext()); }
	"try" { return symbol(Java7Sym.TRY, yytext()); }
	"catch" { return symbol(Java7Sym.CATCH, yytext()); }
	"finally" { return symbol(Java7Sym.FINALLY, yytext()); }
	"throw" { return symbol(Java7Sym.THROW, yytext()); }
	"throws" { return symbol(Java7Sym.THROWS, yytext()); }
	
	
	/* modifiers */
	"public" { return symbol(Java7Sym.PUBLIC, yytext()); }
	"protected" { return symbol(Java7Sym.PROTECTED, yytext()); }
	"private" { return symbol(Java7Sym.PRIVATE, yytext()); }
	"static" { return symbol(Java7Sym.STATIC, yytext()); }
	"abstract" { return symbol(Java7Sym.ABSTRACT, yytext()); }
	"final" { return symbol(Java7Sym.FINAL, yytext()); }
	"native" { return symbol(Java7Sym.NATIVE, yytext()); }
	"synchronized" { return symbol(Java7Sym.SYNCHRONIZED, yytext()); }
	"transient" { return symbol(Java7Sym.TRANSIENT, yytext()); }
	"volatile" { return symbol(Java7Sym.VOLATILE, yytext()); }
	"strictfp" { return symbol(Java7Sym.STRICTFP, yytext()); }
	
	
	/* literals */
	{digit}+ { return symbol(Java7Sym.INTEGER_LITERAL, new Integer(yytext())); }
	
	  /* This is matched together with the minus, because the number is too big to 
     be represented by a positive integer. */
  	 "-2147483648"                  { return symbol(Java7Sym.INTEGER_LITERAL, new Integer(Integer.MIN_VALUE)); }
	
	/*    FloatingPointLiteral	*/
	{FloatLiteral}                 { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Float(yytext().substring(0,yylength()-1))); }
  	{DoubleLiteral}                { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Double(yytext())); }
  	{DoubleLiteral}[dD]            { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Double(yytext().substring(0,yylength()-1))); }
	
	/* novelties */
	"->" { return symbol(Java7Sym.ARROW, yytext()); }
	"::" { return symbol(Java7Sym.DOUBLE_COLON, yytext()); }
	
	
	/* operators */
	">=" { return symbol(Java7Sym.GE, yytext()); }
	"<=" { return symbol(Java7Sym.LE, yytext()); }
	"==" { return symbol(Java7Sym.EQUALS, yytext()); }
	"!=" { return symbol(Java7Sym.NOT_EQUALS, yytext()); }
	"||" { return symbol(Java7Sym.DOUBLE_OR, yytext()); }
	"&&" { return symbol(Java7Sym.DOUBLE_AND, yytext()); }
	"<<" { return symbol(Java7Sym.SHIFT_LEFT, yytext()); }
	">>" { return symbol(Java7Sym.SHIFT_RIGHT, yytext()); }
	">>>" { return symbol(Java7Sym.SHIFT_RIGHT_ARITHM, yytext()); }
	"++" { return symbol(Java7Sym.INC, yytext()); }
	"--" { return symbol(Java7Sym.DEC, yytext()); }
	
	
	"+" { return symbol(Java7Sym.PLUS, yytext()); }
	"-" { return symbol(Java7Sym.MINUS, yytext()); }
	"*" { return symbol(Java7Sym.TIMES, yytext()); }
	"/" { return symbol(Java7Sym.DIVIDE, yytext()); }
	"!" { return symbol(Java7Sym.NOT, yytext()); }
	"&" { return symbol(Java7Sym.AND, yytext()); }
	"|" { return symbol(Java7Sym.OR, yytext()); }
	"^" { return symbol(Java7Sym.XOR, yytext()); }
	"%" { return symbol(Java7Sym.MOD, yytext()); }
	"~" { return symbol(Java7Sym.BITWISE_NOT, yytext()); }
		
	
	"#" { return symbol(Java7Sym.HASH, yytext()); }
	
	/* assignments */
	"+=" { return symbol(Java7Sym.PLUS_EQUALS, yytext()); }
	"-=" { return symbol(Java7Sym.MINUS_EQUALS, yytext()); }
	"*=" { return symbol(Java7Sym.TIMES_EQUALS, yytext()); }
	"/=" { return symbol(Java7Sym.DIV_EQUALS, yytext()); }
	"&=" { return symbol(Java7Sym.AND_EQUALS, yytext()); }
	"|=" { return symbol(Java7Sym.OR_EQUALS, yytext()); }
	"^=" { return symbol(Java7Sym.XOR_EQUALS, yytext()); }
	"%=" { return symbol(Java7Sym.MOD_EQUALS, yytext()); }
	"<<=" { return symbol(Java7Sym.SHIFT_LEFT_EQUALS, yytext()); }
	">>=" { return symbol(Java7Sym.SHIFT_RIGHT_EQUALS, yytext()); }
	">>>=" { return symbol(Java7Sym.SHIFT_RIGHT_ARITHM_EQUALS, yytext()); }
	"=" { return symbol(Java7Sym.BECOMES, yytext()); }
	
	    
	/* delimiters */
	"(" { return symbol(Java7Sym.LPAREN, yytext()); }
	")" { return symbol(Java7Sym.RPAREN, yytext()); }
	"[" { return symbol(Java7Sym.LBRACKET, yytext()); }
	"]" { return symbol(Java7Sym.RBRACKET, yytext()); }
	"{" { return symbol(Java7Sym.LBRACE, yytext()); }
	"}" { return symbol(Java7Sym.RBRACE, yytext()); }
	"<" { return symbol(Java7Sym.LT, yytext()); }
	">" { return symbol(Java7Sym.GT, yytext()); }
	
	
	/* punctuation */
	"..." { return symbol(Java7Sym.ELLIPSIS, yytext()); }
	"." { return symbol(Java7Sym.DOT, yytext()); }
	"," { return symbol(Java7Sym.COMMA, yytext()); }
	":" { return symbol(Java7Sym.COLON, yytext()); }
	";" { return symbol(Java7Sym.SEMICOLON, yytext()); }
	"?" { return symbol(Java7Sym.QUESTION, yytext()); }
	"@" { return symbol(Java7Sym.AT, yytext()); }
	
	/* identifiers */
	{letter} ({letter}|{digit}|_)* { return symbol(Java7Sym.IDENTIFIER, yytext()); }
	
	
	/* whitespace */
	{white}+ { /* ignore whitespace */ }
	
	\"              { string.setLength(0); yybegin(STRING); }
	\'              { string.setLength(0); yybegin(CHARLITERAL); }
	
}

/*    StringLiteral */

<STRING> {
  \"                             { yybegin(YYINITIAL);  return symbol(Java7Sym.STRING_LITERAL,string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { string.append('\t'); }
  \\n                            { string.append('\n'); }

  \\r                            { string.append('\r'); }
  \\\"                           { string.append('\"'); }
  \\\\                           { string.append('\\'); }
}

/*    CharacterLiteral */
	
	
<CHARLITERAL> {
  [^\r\n\'\\]\'            { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, yytext().charAt(0)); }
  
  /* escape sequences */
  "\\b"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\b');}
  "\\t"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\t');}
  "\\n"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\n');}
  "\\f"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\f');}
  "\\r"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\r');}
  "\\\""\'                       { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\"');}
  "\\'"\'                        { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\'');}
  "\\\\"\'                       { yybegin(YYINITIAL); return symbol(Java7Sym.CHARACTER_LITERAL, '\\'); }
  \\[0-3]?[0-7]?[0-7]\' 		 { yybegin(YYINITIAL); 
			                              int val = Integer.parseInt(yytext().substring(1,yylength()-1),8);
			                            return symbol(Java7Sym.CHARACTER_LITERAL, (char)val); }
  
  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {eol}               { throw new RuntimeException("Unterminated character literal at end of line"); }
}



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
