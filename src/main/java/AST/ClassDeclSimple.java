package AST;
import AST.Visitor.Visitor;

public class ClassDeclSimple extends ClassDecl {
  public Identifier i;
  public VarDeclList vl;  
  public MethodDeclList ml;
  public String v;
 
  public ClassDeclSimple(Identifier ai, String visibility, VarDeclList avl, MethodDeclList aml, int ln) {
    super(ln);
    i=ai; vl=avl; ml=aml;
    v = visibility;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
