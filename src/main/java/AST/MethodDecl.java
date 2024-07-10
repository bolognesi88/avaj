package AST;
import AST.Visitor.Visitor;

public class MethodDecl extends ASTNode {
  public Type t;
  public Identifier i;
  public FormalList fl;
  public VarDeclList vl;
  public StatementList sl;
  public Exp e;
  public String v;

  public MethodDecl(Type at, Identifier ai, String visibility, FormalList afl, VarDeclList avl, 
                    StatementList asl, Exp ae, int ln) {
    super(ln);
    t=at; i=ai; fl=afl; vl=avl; sl=asl; e=ae;
    v = visibility;
  }
 
  public void accept(Visitor v) {
    v.visit(this);
  }
}
