package bla;

import java.util.*;
import static java.lang.Math.abs;
import javax.annotation.concurrent.Immutable;
import javax.xml.bind.annotation.XmlTransient;

@Immutable
@java.lang.SuppressWarnings("serial")
public class JavaExample extends Classe2c implements Classe3c {
	public static final double PI = 3.14;
	
	@XmlTransient
	private final float MEIO_PI = 1.6f;
	
	public static final char letra = 'a';
	
	public void	x(int i, int j) throws Throwable, NullPointerException {
		synchronized (this) {
			// bloco vazio :-)
		}
		
		int inteiroMuitoMuitoNegativo = -2147483648;
		
		do {
			int[] vetor = {1,2,3};
			
			vetor[1] = 4;
			
			vetor[2] = vetor[3-3] + 4;;
			
			int[][] matriz = {{1,2,3}, {4,5,6}, {7,8,9}};
			
			matriz[0][0]=0;
			
			if (matriz[1+1].length==44) break;
		}
		while (false);
		
		// ainda não foi hoje que consegui chamar um método.  
		JavaExample um;
		um = new JavaExample();
		um.hum();
		
		this.x(inteiroMuitoMuitoNegativo, dois());
	}
	
	protected int hum() {
		long x = 1;
		
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

	@Override
	public float metodo() {
		return (float) JavaExample.PI;
	}
}

abstract class Classe2c implements Classe3c {
	public Class c = void.class;
	
	private static final int TWO = 1+1;
	
	public static String sure = (1+1 == TWO) ? "True" : "False";
	
	public abstract float metodo();
}

interface Classe3c {
	
}

interface Class4c extends java.util.List{

	public void metodo();
	public void metodo(java.lang.String mutatisMutandis);
	void troublesome() throws Throwable;
}

class Class5c extends JavaExample {
	int i = 3;
	
	public static final int MAX = 50;
	
	int j;
	
	@SuppressWarnings("unused")
	private double x;
	
}

enum Merassaum2 {
	@Anotacao("String Literal Z")
	VALOR1("a"),	
	VALOR2("b");
	
	String descricao;
	
	private Merassaum2(String t) {
		this.descricao = t;
	}
}