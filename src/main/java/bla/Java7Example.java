package bla;

import java.util.*;
import static java.lang.Math.abs;
import javax.annotation.concurrent.Immutable;

@Immutable
@java.lang.SuppressWarnings("serial")
public class Java7Example extends Classe2 implements Classe3 {
	public void	x(int i, int j) throws Throwable, NullPointerException {
	
	}
	
	protected int hum() {
		final int x = 1;
		
		int y = 2;
		
		return y - x;
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