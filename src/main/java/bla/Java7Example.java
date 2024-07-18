package bla;

import java.util.*;
import static java.lang.Math.abs;
import javax.annotation.concurrent.Immutable;

@Immutable
@java.lang.SuppressWarnings("serial")
public class Java7Example extends Classe2 implements Classe3{

}

abstract class Classe2 implements Classe3{
	
}

interface Classe3 {
	
}

interface Class4 extends java.util.List<Integer> {
	
}

class Class5 extends Java7Example {
	
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