package applications;

import com.sun.org.apache.regexp.internal.RE;

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


    private final int MAX_LIMIT = 5000;
    private char[] moves = new char[MAX_LIMIT];
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
        boolean bool = placeAnotherCornerFromUpperSide();

        if(!bool){
            // try recovering
            if( (f[3] == WHITE) || (l[2] == WHITE) ){
                // if_pac_11
                Li(); Ui(); L();
                return placeAnotherCornerFromUpperSide();
            }else if( (d[0] == WHITE) && (f[3] != BLUE) ) {
                // if_pac_12
                Li(); Ui(); L();
                return placeAnotherCornerFromUpperSide();
            }               // if_pac_13
            else if( (f[2] == WHITE) || (r[3] == WHITE)){
                // 14
                R();
                U();
                Ri();
                return placeAnotherCornerFromUpperSide();
            }else if( (d[1] == WHITE) && (r[3]!=RED) ){
                // 15
                Fi();Ui();F();U();
                return placeAnotherCornerFromUpperSide();
            }else if( (r[2] == WHITE) || (b[3] == WHITE) ){
                // 17
                Ri();U();R();U();
                return placeAnotherCornerFromUpperSide();
            }else if( (d[2] == WHITE) && (b[3] != GREEN) ){
                // 18
                Ri();
                Ui();
                Ui();
                R();
                U();
                return placeAnotherCornerFromUpperSide();
            }

        }else{
            // direct return true
            return true;
        }
        return false;
    }

    private boolean placeAnotherCornerFromUpperSide() {

        for(int k1=0; k1<4; k1++){
            if(r[0] == WHITE){
                if(u[2] == BLUE){
                    U();F();U();Fi();
                    // return_pacfus =? return true/false
                    return true;
                }
                // else_pacfus_11
                else if(u[2] == GREEN){
                    Ui(); B(); U(); Bi();
                    return true;
                }else if(u[2] == RED){ // else_pacfus_12
                    R(); U(); Ri();
                    return true;
                }
//                else{
//                    // pacfus_13
//                }
            }else{
                // else_pacfus_1
                U();
            }
        }

        for(int i1=0; i1<4; i1++){
            if(f[1] == WHITE){
                if(u[2] == ORANGE){
                    U(); Li(); Ui(); L();
                    return true;
                }else if(u[2]==RED){ // pacfus_21
                    Ui(); Ri(); Ui();R();
                    return true;
                }else if(u[2] == BLUE ){ // pacfus_22
                    Fi(); Ui(); F();
                    return true;
                }
//                else {
//                    // pacfus_23
//                }
            }else{
                // else_pacfus_2
                U();
            }
        }

        for(int i1=0; i1<4; i1++){
            if(u[2] == WHITE){
                if(f[1] == BLUE){
                    U(); Li(); U();L(); U(); U();
                    Li();
                    Ui(); // <--SHOW SOME RESPECT TO THIS UP INVERSE!
                    L();
                    return true;
                }else if(f[1] == RED){
                    // else_pacfus_31
                    R(); Ui(); Ri();
                    U(); U(); R();
                    U(); Ri();
                    return true;
                }else if(f[1] == GREEN ){
                    // else pacfus 32
                    Ui(); Ri(); U(); R(); U();
                    U(); Ri(); Ui(); R();
                    return true;
                }
            }else{
                // else_pacfus_3
                U();
            }
        }


        return false;
    }

    private boolean doOLL() {
        //look for the number of yellow colours on upper side
        int yellowsOnUp = 0;
        for (int i=0 ; i<4 ; i++) {if (u[i]==YELLOW) {yellowsOnUp++;}}
        if (yellowsOnUp==0) {
            //search for symmetric and non-symmetric
            while (f[1]!=YELLOW) {U();}
            if (b[1]==YELLOW) {
                //case symmetric
                System.out.println("symmetric");
                //algo
                R();R();U();U();
                R();U();U();R();R();
                return true;
            }
            else {
                //case non-symmetric
                System.out.println("non-symmetric");
                //setup move
                if (f[0]==YELLOW) {U();}
                //algo
                F();
                R();U();Ri();Ui();
                R();U();Ri();Ui();
                Fi();
                return true;
            }
        }
        else if (yellowsOnUp==1) {
            //search for sune and anti-sune
            //first search for sune
            if (f[1]==YELLOW) {
                //case sune
                System.out.println("sune");
                //setup moves
                while (u[3]!=YELLOW) {Ui();}
                //algo
                R();U();Ri();U();
                R();U();U();Ri();
                return true;
            }
            //again search for sune
            U();
            if (f[1]==YELLOW) {
                //case sune
                System.out.println("sune");
                //setup moves
                while (u[3]!=YELLOW) {Ui();}
                //algo
                R();U();Ri();U();
                R();U();U();Ri();
                return true;
            }
            else {
                //if still doOLL() is not returned, the case is surely antisune
                System.out.println("antisune");
                //setup moves
                while (u[0]!=YELLOW) {U();}
                //algo
                Ri();Ui();R();Ui();
                Ri();Ui();Ui();R();
                return true;
            }
        }
        else if (yellowsOnUp==2) {
            //search for headlight, chameleon or diagonal corners
            while (f[1]!=YELLOW) {U();}
            if (l[0]==YELLOW) {
                //case diagonal corners
                System.out.println("diagonal corners");
                //algo
                Fi();
                R();U();Ri();Ui();
                Ri();F();R();
                return true;
            }
            if (b[0]==YELLOW) {
                //case chameleon
                System.out.println("chameleon");
                //setup moves
                U();
                U();
                //algo
                R();U();Ri();Ui();
                Ri();F();R();Fi();
                return true;
            }
            else {
                //case headlight
                System.out.println("headlight");
                //setup moves
                Ui();
                //algo
                F();U();R();
                Ui();Ri();Fi();
                return true;
            }
        }
        else if (yellowsOnUp==4) {
            //OLL skip!
            return true;
        }
        return false;
    }
    private boolean doPLL() {
        //first look for adjacent
        for (int i=0 ; i<4 ; i++) {
            if (l[0]==l[1]) {
                if (r[0]==r[1]) {
                    return true; //PLL skip!
                }
                //yes adjacent, apply T perm
                System.out.println("adjacent");
                R();U();Ri();Ui();
                Ri();F();R();R();
                Ui();Ri();Ui();R();
                U();Ri();Fi();
                //finish through Ups!
                while (f[0]!=f[3]) {U();	}
                return true;
            }
            else {U();}
        }
        //unnecessary 4 U moves, so--
        movesPos -= 4;
        //and as still not returned, it must be diagonal case
        System.out.println("diagonal");
        R();Ui();Ri();Ui();F();
        F();Ui();R();U();Ri();
        D();R();R();
        //finish through Ups!
        while (f[0]!=f[3]) {U();	}
        return true;
    }


    /**
     * u -> white
     * l -> orange
     * f -> green
     * r -> red
     * b-> yellow
     * d -> blue
     * */

    public void start(){
        initCube();
        printer();
        printMoves();
        randomShuffle();
        printer();
        printMoves();
        resetMoves();
        printer();
        printMoves();

        placeCorner1();
        placeAnotherCorner();
        placeAnotherCorner();
        placeAnotherCorner();

        doOLL();
        doPLL();

        printer();
        printMoves();
    }

    public void initCube(){
        for(int i=0; i<4; i++){
            u[i] = WHITE;
            l[i] = RED;
            f[i] = GREEN;
            r[i] = ORANGE;
            b[i] = YELLOW;
            d[i] = BLUE;
        }
    }

    public void randomShuffle(){
        L();U();F();B(); D();Li();
        Ui();Di();Ri();Li();
    }

    public void resetMoves(){
        movesPos = 0;
        for(int i=0; i<MAX_LIMIT; i++){
            moves[i] = 0;
        }
    }

    public void printer(){
        System.out.println("  "+(char)u[0]+""+(char)u[1]);
        System.out.println("  "+(char)u[3]+""+(char)u[2]);
        System.out.println(""+(char)l[0]+""+(char)l[1]+""+(char)f[0]+""+(char)f[1]+""+(char)r[0]+""+(char)r[1]+""+(char)b[0]+""+(char)b[1]);
        System.out.println(""+(char)l[3]+""+(char)l[2]+""+(char)f[3]+""+(char)f[2]+""+(char)r[3]+""+(char)r[2]+""+(char)b[3]+""+(char)b[2]);
        System.out.println("  "+(char)d[0]+""+(char)d[1]);
        System.out.println("  "+(char)d[3]+""+(char)d[2]);
    }

    public void printMoves(){
        System.out.println("********************************************");
        for(int i=0; i<=movesPos; i++){
            System.out.print(moves[i]+" ");
        }
        System.out.println("");
        System.out.println("********************************************");
    }
}
