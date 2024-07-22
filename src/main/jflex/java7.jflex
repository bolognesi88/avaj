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
    {Comment}                      { /* ignore */ }
	
	
	/* reserved words */
	/* (put here so that reserved words take precedence over identifiers) */
	
	
	/* declarations */
	"package" { return symbol(Java7Sym.PACKAGE); }
	"import" { return symbol(Java7Sym.IMPORT); }
	"class" { return symbol(Java7Sym.CLASS); }
	"enum" { return symbol(Java7Sym.ENUM); }
	"interface" { return symbol(Java7Sym.INTERFACE); }
	"extends" { return symbol(Java7Sym.EXTENDS); }
	"implements" { return symbol(Java7Sym.IMPLEMENTS); }
	"instanceof" { return symbol(Java7Sym.INSTANCEOF); }
	
	
	/* types */
	"byte" { return symbol(Java7Sym.BYTE); }
	"short" { return symbol(Java7Sym.SHORT); }
	"char" { return symbol(Java7Sym.CHAR); }
	"int" { return symbol(Java7Sym.INT); }
	"long" { return symbol(Java7Sym.LONG); }
	"float" { return symbol(Java7Sym.FLOAT); }
	"double" { return symbol(Java7Sym.DOUBLE); }
	"boolean" { return symbol(Java7Sym.BOOLEAN); }
	
	
	"void" { return symbol(Java7Sym.VOID); }
	"this" { return symbol(Java7Sym.THIS); }
	"super" { return symbol(Java7Sym.SUPER); }
	"new" { return symbol(Java7Sym.NEW); }
	"true" { return symbol(Java7Sym.TRUE); }
	"false" { return symbol(Java7Sym.FALSE); }
	"null" { return symbol(Java7Sym.NULL); }
	
	
	
	/* control flow */
	"if" { return symbol(Java7Sym.IF); }
	"else" { return symbol(Java7Sym.ELSE); }
	"for" { return symbol(Java7Sym.FOR); }
	"while" { return symbol(Java7Sym.WHILE); }
	"return" { return symbol(Java7Sym.RETURN); }
	"do" { return symbol(Java7Sym.DO); }
	"assert" { return symbol(Java7Sym.ASSERT); }
	"switch" { return symbol(Java7Sym.SWITCH); }
	"case" { return symbol(Java7Sym.CASE); }
	"default" { return symbol(Java7Sym.DEFAULT); }
	"break" { return symbol(Java7Sym.BREAK); }
	"continue" { return symbol(Java7Sym.CONTINUE); }
	"try" { return symbol(Java7Sym.TRY); }
	"catch" { return symbol(Java7Sym.CATCH); }
	"finally" { return symbol(Java7Sym.FINALLY); }
	"throw" { return symbol(Java7Sym.THROW); }
	"throws" { return symbol(Java7Sym.THROWS); }
	
	
	/* modifiers */
	"public" { return symbol(Java7Sym.PUBLIC); }
	"protected" { return symbol(Java7Sym.PROTECTED); }
	"private" { return symbol(Java7Sym.PRIVATE); }
	"static" { return symbol(Java7Sym.STATIC); }
	"abstract" { return symbol(Java7Sym.ABSTRACT); }
	"final" { return symbol(Java7Sym.FINAL); }
	"native" { return symbol(Java7Sym.NATIVE); }
	"synchronized" { return symbol(Java7Sym.SYNCHRONIZED); }
	"transient" { return symbol(Java7Sym.TRANSIENT); }
	"volatile" { return symbol(Java7Sym.VOLATILE); }
	"strictfp" { return symbol(Java7Sym.STRICTFP); }
	
	
	/* literals */
	{digit}+ { return symbol(Java7Sym.INTEGER_LITERAL, new Integer(yytext())); }
	
	  /* This is matched together with the minus, because the number is too big to 
     be represented by a positive integer. */
  	 "-2147483648"                  { return symbol(Java7Sym.INTEGER_LITERAL, new Integer(Integer.MIN_VALUE)); }
	
	/*    FloatingPointLiteral	*/
	{FloatLiteral}                 { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Float(yytext().substring(0,yylength()-1))); }
  	{DoubleLiteral}                { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Double(yytext())); }
  	{DoubleLiteral}[dD]            { return symbol(Java7Sym.FLOATING_POINT_LITERAL, new Double(yytext().substring(0,yylength()-1))); }
	
	
	/* operators */
	">=" { return symbol(Java7Sym.GE); }
	"<=" { return symbol(Java7Sym.LE); }
	"==" { return symbol(Java7Sym.EQUALS); }
	"!=" { return symbol(Java7Sym.NOT_EQUALS); }
	"||" { return symbol(Java7Sym.DOUBLE_OR); }
	"&&" { return symbol(Java7Sym.DOUBLE_AND); }
	"<<" { return symbol(Java7Sym.SHIFT_LEFT); }
	">>" { return symbol(Java7Sym.SHIFT_RIGHT); }
	">>>" { return symbol(Java7Sym.SHIFT_RIGHT_ARITHM); }
	"++" { return symbol(Java7Sym.INC); }
	"--" { return symbol(Java7Sym.DEC); }
	
	
	"+" { return symbol(Java7Sym.PLUS); }
	"-" { return symbol(Java7Sym.MINUS); }
	"*" { return symbol(Java7Sym.TIMES); }
	"/" { return symbol(Java7Sym.DIVIDE); }
	"!" { return symbol(Java7Sym.NOT); }
	"&" { return symbol(Java7Sym.AND); }
	"|" { return symbol(Java7Sym.OR); }
	"^" { return symbol(Java7Sym.XOR); }
	"%" { return symbol(Java7Sym.MOD); }
	"~" { return symbol(Java7Sym.BITWISE_NOT); }
		
	
	"#" { return symbol(Java7Sym.HASH); }
	
	/* assignments */
	"+=" { return symbol(Java7Sym.PLUS_EQUALS); }
	"-=" { return symbol(Java7Sym.MINUS_EQUALS); }
	"*=" { return symbol(Java7Sym.TIMES_EQUALS); }
	"/=" { return symbol(Java7Sym.DIV_EQUALS); }
	"&=" { return symbol(Java7Sym.AND_EQUALS); }
	"|=" { return symbol(Java7Sym.OR_EQUALS); }
	"^=" { return symbol(Java7Sym.XOR_EQUALS); }
	"%=" { return symbol(Java7Sym.MOD_EQUALS); }
	"<<=" { return symbol(Java7Sym.SHIFT_LEFT_EQUALS); }
	">>=" { return symbol(Java7Sym.SHIFT_RIGHT_EQUALS); }
	">>>=" { return symbol(Java7Sym.SHIFT_RIGHT_ARITHM_EQUALS); }
	"=" { return symbol(Java7Sym.BECOMES); }
	
	    
	/* delimiters */
	"(" { return symbol(Java7Sym.LPAREN); }
	")" { return symbol(Java7Sym.RPAREN); }
	"[" { return symbol(Java7Sym.LBRACKET); }
	"]" { return symbol(Java7Sym.RBRACKET); }
	"{" { return symbol(Java7Sym.LBRACE); }
	"}" { return symbol(Java7Sym.RBRACE); }
	"<" { return symbol(Java7Sym.LT); }
	">" { return symbol(Java7Sym.GT); }
	
	
	/* punctuation */
	"..." { return symbol(Java7Sym.ELLIPSIS); }
	"." { return symbol(Java7Sym.DOT); }
	"," { return symbol(Java7Sym.COMMA); }
	":" { return symbol(Java7Sym.COLON); }
	";" { return symbol(Java7Sym.SEMICOLON); }
	"?" { return symbol(Java7Sym.QUESTION); }
	"@" { return symbol(Java7Sym.AT); }
	
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
  \\                             { string.append('\\'); }
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
