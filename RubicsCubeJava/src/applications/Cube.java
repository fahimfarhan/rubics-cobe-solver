package applications;

public class Cube {
    private int[] u = new int[4];
    private int[] d = new int[4];
    private int[] l = new int[4];
    private int[] r = new int[4];
    private int[] f = new int[4];
    private int[] b = new int[4];

    private char[] moves = new char[1000];
    private int movesPos = 0;

    public Cube(){}

    private void movU () {
        int temp0 = f[0];
        int temp1 = f[1];

        f[0] = r[0];
        f[1] = r[1];
        r[0] = b[0];
        r[1] = b[1];
        b[0] = l[0];
        b[1] = l[1];
        l[0] = temp0;
        l[1] = temp1;

        temp0 = u[3];
        u[3] = u[2];
        u[2] = u[1];
        u[1] = u[0];
        u[0] = temp0;

        moves[movesPos] = 'U';
        movesPos++;
    }
    private void movUi () {
        int temp0 = f[0];
        int temp1 = f[1];

        f[0] = l[0];
        f[1] = l[1];
        l[0] = b[0];
        l[1] = b[1];
        b[0] = r[0];
        b[1] = r[1];
        r[0] = temp0;
        r[1] = temp1;

        temp0 = u[0];
        u[0] = u[1];
        u[1] = u[2];
        u[2] = u[3];
        u[3] = temp0;

        moves[movesPos] = 'u';
        movesPos++;
    }
    private void movD () {
        int temp3 = f[3];
        int temp2 = f[2];

        f[3] = l[3];
        f[2] = l[2];
        l[3] = b[3];
        l[2] = b[2];
        b[3] = r[3];
        b[2] = r[2];
        r[3] = temp3;
        r[2] = temp2;

        temp3 = u[3];
        u[3] = u[2];
        u[2] = u[1];
        u[1] = u[0];
        u[0] = temp3;

        moves[movesPos] = 'D';
        movesPos++;
    }
    private void movDi () {
        int temp3 = f[3];
        int temp2 = f[2];

        f[3] = r[3];
        f[2] = r[2];
        r[3] = b[3];
        r[2] = b[2];
        b[3] = l[3];
        b[2] = l[2];
        l[3] = temp3;
        l[2] = temp2;

        temp3 = d[0];
        d[0] = d[1];
        d[1] = d[2];
        d[2] = d[3];
        d[3] = temp3;

        moves[movesPos] = 'd';
        movesPos++;
    }
    private void movL () {
        int temp0 = u[0];
        int temp3 = u[3];

        u[0] = b[2];
        u[3] = b[1];
        b[2] = d[0];
        b[1] = d[3];
        d[0] = f[0];
        d[3] = f[3];
        f[0] = temp0;
        f[1] = temp3;

        temp3 = l[3];
        l[3] = l[2];
        l[2] = l[1];
        l[1] = l[0];
        l[0] = temp3;

        moves[movesPos] = 'L';
        movesPos++;
    }
    private void movLi () {
        int temp0 = u[0];
        int temp3 = u[3];

        u[0] = f[0];
        u[3] = f[3];
        f[0] = d[0];
        f[3] = d[3];
        d[0] = b[2];
        d[3] = b[1];
        b[2] = temp0;
        b[1] = temp3;

        temp0 = l[0];
        l[0] = l[1];
        l[1] = l[2];
        l[2] = l[3];
        l[3] = temp0;

        moves[movesPos] = 'l';
        movesPos++;
    }
    private void movR () {
        int temp1 = u[1];
        int temp2 = u[2];

        u[1] = f[1];
        u[2] = f[2];
        f[1] = d[1];
        f[2] = d[2];
        d[1] = b[3];
        d[2] = b[0];
        b[3] = temp1;
        b[0] = temp2;

        temp1 = r[3];
        r[3] = r[2];
        r[2] = r[1];
        r[1] = r[0];
        r[0] = temp1;

        moves[movesPos] = 'R';
        movesPos++;
    }
    private void movRi () {
        int temp1 = u[1];
        int temp2 = u[2];

        u[1] = b[3];
        u[2] = b[0];
        b[3] = d[1];
        b[0] = d[2];
        d[1] = f[1];
        d[2] = f[2];
        f[1] = temp1;
        f[2] = temp2;

        temp1 = r[0];
        r[0] = r[1];
        r[1] = r[2];
        r[2] = r[3];
        r[3] = temp1;

        moves[movesPos] = 'r';
        movesPos++;
    }
    private void movF () {
        int temp3 = u[3];
        int temp2 = u[2];

        u[3] = l[2];
        u[2] = l[1];
        l[2] = d[1];
        l[1] = d[0];
        d[1] = r[0];
        d[0] = r[3];
        r[0] = temp3;
        r[3] = temp2;

        moves[movesPos] = 'F';
        movesPos++;
    }
    private void movFi () {
        int temp3 = u[3];
        int temp2 = u[2];

        u[3] = r[0];
        u[2] = r[3];
        r[0] = d[1];
        r[3] = d[0];
        d[1] = l[2];
        d[0] = l[1];
        l[2] = temp3;
        l[1] = temp2;

        moves[movesPos] = 'f';
        movesPos++;
    }
    private void movB () {
        int temp0 = u[0];
        int temp1 = u[1];

        u[0] = r[1];
        u[1] = r[2];
        r[1] = d[2];
        r[2] = d[3];
        d[2] = l[3];
        d[3] = l[0];
        l[3] = temp0;
        l[0] = temp1;

        moves[movesPos] = 'B';
        movesPos++;
    }
    private void movBi () {
        int temp0 = u[0];
        int temp1 = u[1];

        u[0] = l[3];
        u[1] = l[0];
        l[3] = d[2];
        l[0] = d[3];
        d[2] = r[1];
        d[3] = r[2];
        r[1] = temp0;
        r[2] = temp1;

        moves[movesPos] = 'b';
        movesPos++;
    }

}
