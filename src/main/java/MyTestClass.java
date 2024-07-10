class MyTestClass {
    public static void main(String[] args) {
        System.out.println(6);
    }
}

class Bar {
    public int meep(boolean aVar) {
        int a;
        int b;

        a = 5;
        b = 3;

        while (a > b)
            System.out.println(6);

        if (b > a) {
            b = a;
        } else {
            b = 5 * 2 + 3;
        }

        System.out.println(b);

        a = 6;
        b = 9;

        return b;
    }
}