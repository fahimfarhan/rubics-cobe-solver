package applications;

import java.util.Scanner;

public class Cube {
    /**@param args the command line arguments*/
    int[] u = new int[4];
    int[] d = new int[4];
    int[] l = new int[4];
    int[] r = new int[4];
    int[] f = new int[4];
    int[] b = new int[4];
    int[] temp = new int[2];

    char[] moves = new char[500];
    int movesPos = 0;

    final int YELLOW = 'Y';
    final int WHITE  = 'W';
    final int ORANGE = 'O';
    final int RED    = 'R';
    final int BLUE   = 'B';
    final int GREEN  = 'G';

    public void start() {
        takeInputs();

        //Placing the first corner.
        placeCorner1();
        refreshMoves();

        //Tries to place another corner
        placeAnotherCorner();
        refreshMoves();
        placeAnotherCorner();
        refreshMoves();
        placeAnotherCorner();
        refreshMoves();

        //Last Layer
        doOLL();
        refreshMoves();
        doPLL();
        refreshMoves();

        refreshMoves();
        showMoves();
        showColours();
    }

    boolean placeCorner1 () {
        boolean temp = placeCorner1FromUpperSide();
        if (!temp) {
            if (d[3]==WHITE && l[3]==ORANGE) {temp=true;}
            else {
                movR();
                movR();
                movL();
                movL();
                temp = placeCorner1FromUpperSide();
            }
        }
        return temp;
    }
    boolean placeCorner1FromUpperSide () {
        //if in upperface
        for (int i=0 ; i<4 ; i++) {
            if (u[0]==WHITE) {
                if (l[0]==GREEN) {
                    movU();
                    movB();
                    movB();
                    return true;
                }
                else {movU();}
            }
            else {movU();}
        }
        //search in left face
        for (int i=0 ; i<4 ; i++) {
            if (l[0]==WHITE) {
                if (b[1]==GREEN) {
                    movB();
                    return true;
                }
                else {
                    movU();
                }
            }
            else {
                movU();
            }
        }
        //search in back face
        for (int i=0 ; i<4 ; i++) {
            if (b[1]==WHITE) {
                if (u[0]==GREEN) {
                    movLi();
                    return true;
                }
                else {
                    movU();
                }
            }
            else {
                movU();
            }
        }
        return false;
    }
    boolean placeAnotherCorner () {
        boolean temp = placeAnotherCornerFromUpperSide();
        if (!temp) {
            //recover a corner from down side
            //try recovering FLD
            if (f[3]==WHITE || l[2]==WHITE) {
                movLi();movUi();movL();
                temp = placeAnotherCornerFromUpperSide();
            }
            else if (d[0]==WHITE && f[3]!=BLUE) {
                movLi();movUi();movL();
                temp = placeAnotherCornerFromUpperSide();
            }
            //try recovering FRD
            else if (f[2]==WHITE || r[3]==WHITE) {
                movR();movU();movRi();
                temp = placeAnotherCornerFromUpperSide();
            }
            else if (d[1]==WHITE && r[3]!=RED) {
                movFi();movUi();movF();movU();
                temp = placeAnotherCornerFromUpperSide();
            }
            //try  recovering RBD
            else if (r[2]==WHITE || b[3]==WHITE) {
                movRi();movU();movR();movU();
                temp = placeAnotherCornerFromUpperSide();
            }
            else if (d[2]==WHITE && b[3]!=GREEN) {
                movRi();movUi();movUi();movR();movU();
                temp = placeAnotherCornerFromUpperSide();
            }
        }
        return temp;
    }
    boolean placeAnotherCornerFromUpperSide () {
        //search for a RURi :3
        for (int i=0 ; i<4 ; i++) {
            if (r[0]==WHITE) {
                if (u[2]==BLUE) {
                    movU();
                    movF();
                    movU();
                    movFi();
                    return true;
                }
                else if (u[2]==GREEN) {
                    movUi();
                    movB();
                    movU();
                    movBi();
                    return true;
                }
                else if (u[2]==RED) {
                    movR();
                    movU();
                    movRi();
                    return true;
                }
            }
            else {movU();}
        }
        //search for the mirror of previous one
        for (int i=0 ; i<4 ; i++) {
            if (f[1]==WHITE) {
                if (u[2]==ORANGE) {
                    movU();
                    movLi();
                    movUi();
                    movL();
                    return true;
                }
                else if (u[2]==RED) {
                    movUi();
                    movRi();
                    movUi();
                    movR();
                    return true;
                }
                else if (u[2]==BLUE) {
                    movFi();
                    movUi();
                    movF();
                    return true;
                }
            }
            else {movU();}
        }
        //search for upper side
        for (int i=0 ; i<4 ; i++) {
            if (u[2]==WHITE) {
                if (f[1]==BLUE) {
                    movU();
                    movLi();
                    movU();
                    movL();
                    movU();
                    movU();
                    movLi();
                    movUi();
                    movL();
                    return true;
                }
                else if (f[1]==RED) {
                    movR();
                    movUi();
                    movRi();
                    movU();
                    movU();
                    movR();
                    movU();
                    movRi();
                    return true;
                }
                else if (f[1]==GREEN) {
                    movUi();
                    movRi();
                    movU();
                    movR();
                    movU();
                    movU();
                    movRi();
                    movUi();
                    movR();
                    return true;
                }
            }
            else {movU();}
        }
        return false;
    }

    //the following function is not applied.
    int bringUpFromDownSide () {
        //returns 0 if is not successfull
        //returns 1 if one corner is already placed correctly
        if (d[0]==WHITE) {
            if (f[3]==RED) {
                return 1;
            }
        }
        return 0;
    }
    //The following function is still not completed (and not applied, obviously).
    //It can be applied for efficient solution, but may lead to high runtime and long code.
    boolean placeAnotherCornerFromDownSide () {
        if (l[2]==WHITE) {
            if (f[3]==ORANGE) {
                movLi();
                movUi();
                movL();
                movU();
                movLi();
                movUi();
                movL();
                return true;
            }
            else if (f[3]==BLUE) {
                movLi();
                movUi();
                movL();
                movFi();
                movUi();
                movF();
                return true;
            }
            else if (f[3]==RED) {
                movLi();
                movUi();
                movL();
                movUi();
                movRi();
                movUi();
                movR();
                return true;
            }
            else {return false;}
        }
        return false;
    }

    boolean doOLL() {
        //look for the number of yellow colours on upper side
        int yellowsOnUp = 0;
        for (int i=0 ; i<4 ; i++) {if (u[i]==YELLOW) {yellowsOnUp++;}}
        if (yellowsOnUp==0) {
            //search for symmetric and non-symmetric
            while (f[1]!=YELLOW) {movU();}
            if (b[1]==YELLOW) {
                //case symmetric
                System.out.println("symmetric");
                //algo
                movR();movR();movU();movU();
                movR();movU();movU();movR();movR();
                return true;
            }
            else {
                //case non-symmetric
                System.out.println("non-symmetric");
                //setup move
                if (f[0]==YELLOW) {movU();}
                //algo
                movF();
                movR();movU();movRi();movUi();
                movR();movU();movRi();movUi();
                movFi();
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
                while (u[3]!=YELLOW) {movUi();}
                //algo
                movR();movU();movRi();movU();
                movR();movU();movU();movRi();
                return true;
            }
            //again search for sune
            movU();
            if (f[1]==YELLOW) {
                //case sune
                System.out.println("sune");
                //setup moves
                while (u[3]!=YELLOW) {movUi();}
                //algo
                movR();movU();movRi();movU();
                movR();movU();movU();movRi();
                return true;
            }
            else {
                //if still doOLL() is not returned, the case is surely antisune
                System.out.println("antisune");
                //setup moves
                while (u[0]!=YELLOW) {movU();}
                //algo
                movRi();movUi();movR();movUi();
                movRi();movUi();movUi();movR();
                return true;
            }
        }
        else if (yellowsOnUp==2) {
            //search for headlight, chameleon or diagonal corners
            while (f[1]!=YELLOW) {movU();}
            if (l[0]==YELLOW) {
                //case diagonal corners
                System.out.println("diagonal corners");
                //algo
                movFi();
                movR();movU();movRi();movUi();
                movRi();movF();movR();
                return true;
            }
            if (b[0]==YELLOW) {
                //case chameleon
                System.out.println("chameleon");
                //setup moves
                movU();
                movU();
                //algo
                movR();movU();movRi();movUi();
                movRi();movF();movR();movFi();
                return true;
            }
            else {
                //case headlight
                System.out.println("headlight");
                //setup moves
                movUi();
                //algo
                movF();movU();movR();
                movUi();movRi();movFi();
                return true;
            }
        }
        else if (yellowsOnUp==4) {
            //OLL skip!
            System.out.println("skip");
            return true;
        }
        return false;
    }
    boolean doPLL() {
        //first look for adjacent
        for (int i=0 ; i<4 ; i++) {
            //System.out.println("##Part of Debugging##");
            //System.out.println(l[0] + " " + l[1] + " " + r[0] + " " + r[1]);
            if (l[0]==l[1]) {
                if (r[0]==r[1]) {
                    //PLL skip!
                    System.out.println("skip");
                    while (f[0]!=f[3]) {movU();	}
                    return true;
                }
                //yes adjacent, apply T perm
                System.out.println("adjacent");
                movR();movU();movRi();movUi();
                movRi();movF();movR();movR();
                movUi();movRi();movUi();movR();
                movU();movRi();movFi();
                //finish through Ups!
                while (f[0]!=f[3]) {movU();	}
                return true;
            }
            else {movU();}
        }
        //and as still not returned, it must be diagonal case
        System.out.println("diagonal");
        movR();movUi();movRi();movUi();movF();
        movF();movUi();movR();movU();movRi();
        movD();movR();movR();
        //finish through Ups!
        while (f[0]!=f[3]) {movU();	}
        return true;
    }

    void movU () {
        temp[0] = b[0];
        temp[1] = b[1];

        b[0] = l[0];
        b[1] = l[1];

        l[0]=f[0];
        l[1]=f[1];

        f[0]=r[0];
        f[1]=r[1];

        r[0]=temp[0];
        r[1]=temp[1];
        /**
         * top side rotate
         * */
        temp[1] = u[0];
        u[0] = u[3];
        u[3] = u[2];
        u[2] = u[1];
        u[1] = temp[1];

        moves[movesPos] = 'U';
        movesPos++;
    }
    void movUi () {
        temp[0] = b[0];
        temp[1] = b[1];

        b[0] = r[0];
        b[1] = r[1];

        r[0]=f[0];
        r[1]=f[1];

        f[0]=l[0];
        f[1]=l[1];

        l[0]=temp[0];
        l[1]=temp[1];
        /**
         * top side rotate
         * */
        temp[1] = u[0];
        u[0] = u[1];
        u[1] = u[2];
        u[2] = u[3];
        u[3] = temp[1];

        moves[movesPos] = 'u';
        movesPos++;
    }
    void movD () {
        temp[0] = b[3];
        temp[1] = b[2];

        b[3] = r[3];
        b[2] = r[2];

        r[3]=f[3];
        r[2]=f[2];

        f[3]=l[3];
        f[2]=l[2];

        l[3]=temp[0];
        l[2]=temp[1];
        /**
         * d side rotate
         * */
        temp[1] = d[0];
        d[0] = d[3];
        d[3] = d[2];
        d[2] = d[1];
        d[1] = temp[1];

        moves[movesPos] = 'D';
        movesPos++;
    }
    void movDi () {
        temp[0] = b[3];
        temp[1] = b[2];

        b[3] = l[3];
        b[2] = l[2];

        l[3]=f[3];
        l[2]=f[2];

        f[3]=r[3];
        f[2]=r[2];

        r[3]=temp[0];
        r[2]=temp[1];
        /**
         * d side rotate
         * */

        temp[1] = d[0];
        d[0] = d[1];
        d[1] = d[2];
        d[2] = d[3];
        d[3] = temp[1];

        moves[movesPos] = 'd';
        movesPos++;
    }
    void movL () {
        temp[0] = b[1];
        temp[1] = b[2];

        b[2]=d[0];
        b[1]=d[3];

        d[0]=f[0];
        d[3]=f[3];

        f[0]=u[0];
        f[3]=u[3];

        u[0] = temp[1];
        u[3] = temp[0];

        /*l sode rotate*/

        temp[1] = l[0];
        l[0] = l[3];
        l[3] = l[2];
        l[2] = l[1];
        l[1] = temp[1];

        moves[movesPos] = 'L';
        movesPos++;
    }
    void movLi () {
        temp[0] = b[1];
        temp[1] = b[2];

        b[2]=u[0];
        b[1]=u[3];

        u[0]=f[0];
        u[3]=f[3];

        f[0]=d[0];
        f[3]=d[3];

        d[0] = temp[1];
        d[3] = temp[0];

        /*l side rotate*/
        temp[1] = l[0];
        l[0] = l[1];
        l[1] = l[2];
        l[2] = l[3];
        l[3] = temp[1];

        moves[movesPos] = 'l';
        movesPos++;
    }
    void movR () {
        temp[0] = b[0];
        temp[1] = b[3];

        b[0]=u[2];
        b[3]=u[1];

        u[1]=f[1];
        u[2]=f[2];

        f[1]=d[1];
        f[2]=d[2];

        d[1] = temp[1];
        d[2] = temp[0];
        /**
         * r side rotate*/
        temp[1] = r[0];
        r[0] = r[3];
        r[3] = r[2];
        r[2] = r[1];
        r[1] = temp[1];

        moves[movesPos] = 'R';
        movesPos++;
    }
    void movRi () {
        temp[0] = b[0];
        temp[1] = b[3];

        b[0]=d[2];
        b[3]=d[1];

        d[1]=f[1];
        d[2]=f[2];

        f[1]=u[1];
        f[2]=u[2];

        u[1] = temp[1];
        u[2] = temp[0];
        /**
         * r side rotate*/
        temp[1] = r[0];
        r[0] = r[1];
        r[1] = r[2];
        r[2] = r[3];
        r[3] = temp[1];

        moves[movesPos] = 'r';
        movesPos++;
    }
    void movF () {
        temp[0] = u[3];
        temp[1] = u[2];

        u[3] = l[2];
        u[2] = l[1];

        l[1] = d[0];
        l[2] = d[1];

//        d[0] = r[0];
//        d[1] = r[3];
        d[0] = r[3];
        d[1] = r[0];

        r[0] = temp[0];
        r[3] = temp[1];

        /*f rotate*/
        temp[1] = f[0];
        f[0] = f[3];
        f[3] = f[2];
        f[2] = f[1];
        f[1] = temp[1];

        moves[movesPos] = 'F';
        movesPos++;
    }
    void movFi () {
        temp[0] = u[3];
        temp[1] = u[2];

        u[3] = r[0];
        u[2] = r[3];

        r[0] = d[1];
        r[3] = d[0];

        d[0] = l[1];
        d[1] = l[2];

//        l[1] = temp[0];
//        l[2] = temp[1];
        l[1] = temp[1];
        l[2] = temp[0];

        /*f rotate*/
        temp[1] = f[0];
        f[0] = f[1];
        f[1] = f[2];
        f[2] = f[3];
        f[3] = temp[1];

        moves[movesPos] = 'f';
        movesPos++;
    }
    void movB () {
        temp[0] = u[0];
        temp[1] = u[1];

        u[0] = r[1];
        u[1] = r[2];

        r[1] = d[2];
        r[2] = d[3];

        d[3] = l[0];
        d[2] = l[3];

        l[0] = temp[1];
        l[3] = temp[0];

        /*b rotate*/
        temp[1] = b[0];
        b[0] = b[3];
        b[3] = b[2];
        b[2] = b[1];
        b[1] = temp[1];

        moves[movesPos] = 'B';
        movesPos++;
    }
    void movBi () {
        temp[0] = u[0];
        temp[1] = u[1];

        u[0] = l[3];
        u[1] = l[0];

        l[0] = d[3];
        l[3] = d[2];

        d[3] = r[2];
        d[2] = r[1];

        r[2] = temp[1];
        r[1] = temp[0];

        /*b rotate*/
        temp[1] = b[0];
        b[0] = b[1];
        b[1] = b[2];
        b[2] = b[3];
        b[3] = temp[1];

        moves[movesPos] = 'b';
        movesPos++;
    }

    void refreshMoves() {
        for (int i=0 ; i<movesPos ; i++) {
            //check for a move and its reverse
            if (i+1<movesPos) {
                if (moves[i]-moves[i+1]==32 || moves[i]-moves[i+1]==-32) {
                    movesPos -= 2;
                    for (int j=i ; j<movesPos ; j++) {
                        moves[j] = moves[j+2];
                    }
                }
            }
            //check for UUU, UUUU or such things
            if (i+2<movesPos) {
                if (moves[i]==moves[i+1] && moves[i]==moves[i+2]) {
                    //UUUU case
                    if (i+3<movesPos && moves[i]==moves[i+3]) {
                        movesPos -= 4;
                        for (int j=i ; j<movesPos ; j++) {
                            moves[j] = moves[j+4];
                        }
                    }
                    //UUU case
                    else {
                        if (moves[i]<=90) {moves[i] += 32;}
                        else {moves[i] -= 32;}
                        movesPos -= 2;
                        for (int j=i+1 ; j<movesPos ; j++) {
                            moves[j] = moves[j+2];
                        }
                    }
                }
            }
        }
    }
    void showMoves () {
        if (movesPos==0) {
            System.out.println("No moves needed!");
            return;
        }
        for (int i=0 ; i<movesPos ; i++) {
            System.out.print(moves[i] + " ");
        }
        System.out.println();
    }
    void showColours () {
        System.out.println("\t\t"+u[0]+"\t"+u[1]);
        System.out.println("\t\t"+u[3]+"\t"+u[2]);
        System.out.println(l[0]+"\t"+l[1]+"\t"+f[0]+"\t"+f[1]+"\t"+r[0]+"\t"+r[1]+"\t"+b[0]+"\t"+b[1]);
        System.out.println(l[3]+"\t"+l[2]+"\t"+f[3]+"\t"+f[2]+"\t"+r[3]+"\t"+r[2]+"\t"+b[3]+"\t"+b[2]);
        System.out.println("\t\t"+d[0]+"\t"+d[1]);
        System.out.println("\t\t"+d[3]+"\t"+d[2]);
    }

    private void takeInputs() {
        Scanner sc = new Scanner(System.in);
        String st = new String();
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    u[i] = 1;
                    break;
                case 'w':
                    u[i] = -1;
                    break;
                case 'o':
                    u[i] = 2;
                    break;
                case 'r':
                    u[i] = -2;
                    break;
                case 'b':
                    u[i] = 3;
                    break;
                case 'g':
                    u[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }
        }
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    l[i] = 1;
                    break;
                case 'w':
                    l[i] = -1;
                    break;
                case 'o':
                    l[i] = 2;
                    break;
                case 'r':
                    l[i] = -2;
                    break;
                case 'b':
                    l[i] = 3;
                    break;
                case 'g':
                    l[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }
        }
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    f[i] = 1;
                    break;
                case 'w':
                    f[i] = -1;
                    break;
                case 'o':
                    f[i] = 2;
                    break;
                case 'r':
                    f[i] = -2;
                    break;
                case 'b':
                    f[i] = 3;
                    break;
                case 'g':
                    f[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }
        }
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    r[i] = 1;
                    break;
                case 'w':
                    r[i] = -1;
                    break;
                case 'o':
                    r[i] = 2;
                    break;
                case 'r':
                    r[i] = -2;
                    break;
                case 'b':
                    r[i] = 3;
                    break;
                case 'g':
                    r[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }

        }
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    b[i] = 1;
                    break;
                case 'w':
                    b[i] = -1;
                    break;
                case 'o':
                    b[i] = 2;
                    break;
                case 'r':
                    b[i] = -2;
                    break;
                case 'b':
                    b[i] = 3;
                    break;
                case 'g':
                    b[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }
        }
        for (int i=0 ; i<4 ; i++) {
            st = sc.nextLine();
            switch (st.charAt(0)) {
                case 'y':
                    d[i] = 1;
                    break;
                case 'w':
                    d[i] = -1;
                    break;
                case 'o':
                    d[i] = 2;
                    break;
                case 'r':
                    d[i] = -2;
                    break;
                case 'b':
                    d[i] = 3;
                    break;
                case 'g':
                    d[i] = -3;
                    break;
                default:
                    i--;
                    break;
            }
        }
    }
}
