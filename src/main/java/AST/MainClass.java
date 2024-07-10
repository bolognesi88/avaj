package AST;
import AST.Visitor.Visitor;

public class MainClass extends ASTNode{
  public Identifier i1,i2;
  public VarDeclList dl;
  public StatementList sl;
  public String v;

  public MainClass(Identifier ai1, Identifier ai2, VarDeclList avl, StatementList asl, String visibility, int ln) {
    super(ln);
    i1=ai1; i2=ai2; sl=asl; dl = avl;
    v=visibility;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }
}

