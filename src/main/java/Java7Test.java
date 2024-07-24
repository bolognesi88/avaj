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
    	
    	Java7Parser p=null;
        try {
            // create a scanner on the input file
            Java7Scanner s = new Java7Scanner(new FileReader(FILE));          
            Symbol t = s.next_token();
            
            Integer lastLeft =null;
            
            while (t.sym != Java7Sym.EOF){ 
                // print each token that we scan
            
            	Integer currLeft = t.left;
            	if (currLeft!=lastLeft) {
            		System.out.print("\nInput line "+currLeft+": ");
            		lastLeft = currLeft;
            	}
            	
                System.out.print(s.symbolToString(t));
                System.out.print("(#"+t.sym+") ");
                
                // if (t.sym == Java7Sym.SEMICOLON ||t.sym == Java7Sym.LBRACE || t.sym == Java7Sym.RBRACE) System.out.println();
                
                t = s.next_token(); 
            }            
            System.out.println("\nLexical analysis successfull");
            
            s.yyclose();
            
        
            s = new Java7Scanner(new FileReader(FILE));        
            
            boolean debugging = true;
            
            if (debugging) {
	            p = new Java7Parser(s) {
	            	@Override
	            	public Symbol scan() throws java.lang.Exception {
	            		Symbol s = super.scan();
	            		// dump_stack();
	            		   debug_message("============ Parse Stack Dump ============");

	            		      /* dump the stack */
	            		      for (int i=0; i<stack.size(); i++)
	            			{
	            			  debug_message("Symbol #" + 
	            					((Symbol)stack.elementAt(i)).sym
	            			  		+ " " +((Symbol)stack.elementAt(i)).value 
	            					//+ " State: " + ((Symbol)stack.elementAt(i)).parse_state)
	            			  			);
	            			}
	            		      debug_message("==========================================");
	            		    
	            		System.err.println("\\+"+s.sym+": "+symbl_name_from_id(s.sym));
	            		return s;
	            	}
	            };
            }
            else p = new Java7Parser(s); 
            
            Symbol root;
            root = p.parse();

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
            if (p!=null) {
            	try {
					System.out.println("next:" +p.getScanner().next_token());
				} 
            	catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
            }
            
            
            // Syntax error at character < LINE NUMBER !!!! > of input
            e.printStackTrace();
        }
    }

}
