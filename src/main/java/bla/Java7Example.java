package bla;

import java.util.*;
import static java.lang.Math.abs;
import javax.annotation.concurrent.Immutable;
import javax.xml.bind.annotation.XmlTransient;

@Immutable
@java.lang.SuppressWarnings("serial")
public class Java7Example extends Classe2 implements Classe3 {
	public static final double PI = 3.14;
	
	@XmlTransient
	private final float MEIO_PI = 1.6f;
	
	public static final char letra = 'a';
	
	public void	x(int i, int j) throws Throwable, NullPointerException {
		synchronized (this) {
			// bloco vazio :-)
		}
		
		final int inteiroMuitoMuitoNegativo = -2147483648;
		
		do {
			int[] vetor = {1,2,3};
			
			int[][] matriz = {{1,2,3}, {4,5,6}, {7,8,9}};
			
			if (true) break;
		}
		while (false);
		
		// ainda não foi hoje que consegui chamar um método.  
		Java7Example um;
		// um = new Java7Example();
		// um.hum();
	}
	
	protected int hum() {
		final long x = 1;
		
		int y = 2;
		
		try {
			if (x==2) return 1;
			
			if (x==3) return 1; else { /* nada */ };
		}
		catch (RuntimeException t) {
			throw t;
		}
		finally {
			// nada
		}
		
		assert x < 1000;
		
		return (int) (y / 1 - x * 1);
	}
	
	/**
	 * Este método retorna o numero dois.
	 * Isto é um Documentation Comment (javadoc)
	 * @return
	 */
	public int dois () {
		return 2;
	}
}

abstract class Classe2 implements Classe3 {
	public Class c = void.class;
	
	private static final int TWO = 1+1;
	
	public static String sure = (1+1 == TWO) ? "True" : "False";
	
	
}

interface Classe3 {
	
}

interface Class4 extends java.util.List<Integer> {

}

class Class5 extends Java7Example {
	int i = 3;
	
	public static final int MAX = 50;
	
	int j;
	
	@SuppressWarnings("unused")
	private double x;
	
}

enum Merassaum {
	@Anotacao("String Literal Z")
	VALOR1,	
	VALOR2;
}

@interface Anotacao {
	String[] value();	
	int outro() default 10;
	public static final int MAX = 20;
}