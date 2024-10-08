import java.io.File;
import java.io.FileReader;

import Parser.Java7Parser;
import Scanner.Java7Scanner;

public class WorkspaceFullscan{
	
    public static void main(String [] args) {
    	try {
	    	final String BASEDIR = "C:\\Java\\eclipse-workspace";
	    	parseDirectory(new File(BASEDIR));
    	}
    	catch (Throwable t) {
    		System.out.println("erro em "+lastFileName+" "+t);
    	}
    	finally {
	    	System.out.println();
	    	System.out.println("======================================");
	    	System.out.println("success: "+success);
	    	System.out.println("error: "+error);
    	}
    }
    
    private static void parseDirectory(File f) {
    	if (!f.isDirectory()) return ;
    	
    	for (File g: f.listFiles()) {
    		if (g.isDirectory()) {
    			parseDirectory(g);
    		}
    		else if (g.getName().endsWith((".java"))) {
    			parseFile(g);
    		}
    	}
    }
    
    private static int success=0;
    private static int error=0;
    private static String lastFileName = null;
    
    private static void parseFile(File f) {
    	lastFileName = f.getAbsolutePath();
    	
        try {
            // create a scanner on the input file
            Java7Scanner s = new Java7Scanner(new FileReader(f));        
            Java7Parser p = new Java7Parser(s); 
            
            p.parse();

            System.out.println(f.getAbsolutePath()+": Parsing successfull");
            success++;
        } 
        catch (Exception e) {
        	error++;
            System.out.println(f.getAbsolutePath()+": Error: " + e.toString());
        }
    }

}
