import Scanner.*;
import Parser.*;
import AST.*;
import AST.Visitor.*;
import Throwables.*;
import java_cup.runtime.Symbol;

import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.*;

public class Java7Test{
	
    public static void main(String [] args) {
    	final String FILE = "C:\\Java\\eclipse-workspace\\avaj\\src\\main\\java\\bla\\Java7Example.java";
        try {
            // create a scanner on the input file
            Java7Scanner s = new Java7Scanner(new FileReader(FILE));
            
            Symbol t = s.next_token();
            while (t.sym != Java7Sym.EOF){ 
                // print each token that we scan
                System.out.print(s.symbolToString(t) + "(#"+t.sym+") ");
                
                if (t.sym == Java7Sym.SEMICOLON) System.out.println();
                
                t = s.next_token(); 
            }            
            System.out.println("\nLexical analysis successfull");
            
            s.yyclose();
        
            s = new Java7Scanner(new FileReader(FILE));            
            Java7Parser p = new Java7Parser(s);
            Symbol root;
            root = p.debug_parse();

            // Program prog = (Program) root.value;
            System.out.println(root.value);
            
            System.out.println("\nParsing successfull"); 
        } catch (CompilerException e) {
            // an error in the user's arguments or input, or some
            // other kind of error that we've already handled in the
            // appropriate way (not a bug that the error got here)
            System.err.println(e.getMessage());
        } catch (Exception e) {
            // yuck: some kind of error in the compiler implementation
            // that we're not expecting (a bug!)
            System.err.println("Unexpected internal compiler error: " + 
                               e.toString());
            // print out a stack dump
            e.printStackTrace();
        }
    }
}
