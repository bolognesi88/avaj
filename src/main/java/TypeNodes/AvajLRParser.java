package TypeNodes;

import java.util.HashMap;
import java.util.Map;

import java_cup.runtime.Scanner;
import java_cup.runtime.Symbol;
import java_cup.runtime.SymbolFactory;

public abstract class AvajLRParser extends java_cup.runtime.lr_parser{

	public AvajLRParser(Scanner s) {
		super(s);
	}

	public AvajLRParser() {
		super();
	}

	public AvajLRParser(Scanner s, SymbolFactory sf) {
		super(s,sf);
	}

	private AvajSymbolFactory interceptor=null;
	
	@Override
	public SymbolFactory getSymbolFactory() {
		if (interceptor==null) {
			interceptor = new AvajSymbolFactory(super.getSymbolFactory());
		}
		return interceptor;
	}
	
	public static Map<Integer, String> symbolNames = new HashMap<Integer, String>();

	public static class AvajSymbolFactory implements SymbolFactory {
		
		private SymbolFactory delegate;
		
		public Symbol newSymbol(String name, int code, Object arg2) {
			symbolNames.put(code, name);
			return delegate.newSymbol(name, code, arg2);
		}

		public Symbol newSymbol(String name, int code, Symbol arg2, Object arg3) {
			symbolNames.put(code, name);
			return delegate.newSymbol(name, code, arg2, arg3);
		}

		public Symbol newSymbol(String name, int code, Symbol arg2, Symbol arg3, Object arg4) {
			symbolNames.put(code, name);
			return delegate.newSymbol(name, code, arg2, arg3, arg4);
		}

		public Symbol newSymbol(String name, int code, Symbol arg2, Symbol arg3) {
			symbolNames.put(code, name);
			return delegate.newSymbol(name, code, arg2, arg3);
		}

		public Symbol newSymbol(String name, int code) {
			symbolNames.put(code, name);
			return delegate.newSymbol(name, code);
		}

		public Symbol startSymbol(String name, int code, int arg2) {
			return delegate.startSymbol(name, code, arg2);
		}

		public AvajSymbolFactory (SymbolFactory delegate) {
			this.delegate = delegate;
		}
	}
}
