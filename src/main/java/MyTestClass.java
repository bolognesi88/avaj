public class MyTestClass {
    public static void main(String[] args) {
    	Bar b;
    	
    	b = new Bar();
        System.out.println(b.meep(false));
    }
}

class Bar {
	int property;
	
    public int meep(boolean aVar) {
        int a;
        int b;

        a = 5;
        b = 3;

        while (a < b && b==a)
            System.out.println(6);

        if (b >= a) {
            b = a;
        } else {
            b = 5 * 2 + 3 / a;
        }

        System.out.println(b);

        a = 6;
        b = 9;

        b = this.meep2(a, b);
                        
        return b;
    }
    
    private int meep2(int v, int j) {
    	System.out.println(2);
    	return v;
    }
    
    protected void meep3() {
    	System.out.println(3);
    }
    
    static void meep4() {
    	System.out.println(4);
    }
}