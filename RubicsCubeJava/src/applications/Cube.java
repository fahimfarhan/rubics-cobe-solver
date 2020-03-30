package applications;

public class Cube {
    private int[] u = new int[4];
    private int[] d = new int[4];
    private int[] l = new int[4];
    private int[] r = new int[4];
    private int[] f = new int[4];
    private int[] b = new int[4];

    private final int YELLOW = 'y';
    private final int WHITE  = 'w';
    private final int ORANGE = 'o';
    private final int RED    = 'r';
    private final int BLUE   = 'b';
    private final int GREEN  = 'g';

    private char[] moves = new char[1000];
    private int movesPos = 0;

    public Cube(){}

    private void U () {
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
    private void Ui () {
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
    private void D () {
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
    private void Di () {
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
    private void L () {
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
    private void Li () {
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
    private void R () {
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
    private void Ri () {
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
    private void F () {
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
    private void Fi () {
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
    private void B () {
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
    private void Bi () {
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

    private boolean placeCorner1FromUpperSide() {
        for(int i=0; i<4; i++){// while(true){
            if( (u[0] == WHITE) && (l[0] == GREEN) ){
                U();B();B();
                return true;
            }else{
                U();
            }
        }

        for(int i=0; i<4; i++){
            if( (l[0] == WHITE) && (b[1] == GREEN) ){
                B();
                return true;
            }else{
                U();
            }
        }

        for(int i=0; i<4; i++){
            if( (b[1] == WHITE) && (u[0]==GREEN) ){
                Li();
                return true;
            }else{
                U();
            }
        }
        return false;
    }

    private boolean placeCorner1() {
        boolean b = placeCorner1FromUpperSide();
        if(b){
            return b;
        }else{
            if( (d[3] == WHITE) && (l[3] == ORANGE) ){
                return true;
            }else{
                R(); R(); L(); L();
                return placeCorner1FromUpperSide();
            }
        }
    }

    private boolean placeAnotherCorner() {
        boolean bool = false;


        return false;
    }

}
