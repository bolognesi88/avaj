package AST;
import AST.Visitor.Visitor;

public class ClassDeclExtends extends ClassDecl {
  public Identifier i;
  public Identifier j;
  public VarDeclList vl;  
  public MethodDeclList ml;
  public String v;
 
  public ClassDeclExtends(Identifier ai, Identifier aj, String visibility, 
                  VarDeclList avl, MethodDeclList aml, int ln) {
    super(ln);
    i=ai; j=aj; vl=avl; ml=aml;
    v=visibility;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}
