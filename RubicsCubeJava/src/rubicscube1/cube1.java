package rubicscube1;

import org.omg.PortableServer.LIFESPAN_POLICY_ID;

/**
 * Created by Fahim on 11/21/2016.
 */
public class cube1 {
    /*color*/
    final char white = 'W' ;
    final char blue = 'B';
    final char red = 'R';
    final char yellow = 'Y';
    final char green = 'G';
    final char orange = 'O';

    /*color*/
    char up[][], down[][], left[][], right[][],back[][], front[][], temp[], temp1;
    /*up ==white, front=green, left=orange, right= red, back = blue, down = yellow*/
    /*constructor*/
    cube1(){
        up = new char[2][2];
        down = new char[2][2];
        left = new char[2][2];
        right = new char[2][2];
        front = new char[2][2];
        back = new char[2][2];
        temp = new char[2];

        for(int i=0; i<2; i++)
            for(int j=0; j<2; j++){

                up[i][j] = yellow;
                front[i][j]= green;
                left[i][j]=red;
                right[i][j]=orange;
                back[i][j]=blue;
                down[i][j]=white;
            }
    }
    /**
     * update 1
     * Step1: the stndard moves
     * */

    void Ui(){

        temp[0] = back[0][0];
        temp[1] = back[0][1];

        back[0][0] = right[0][0];
        back[0][1] = right[0][1];

        right[0][0]=front[0][0];
        right[0][01]=front[0][01];

        front[0][0]=left[0][0];
        front[0][01]=left[0][01];

        left[0][0]=temp[0];
        left[0][1]=temp[1];
        /**
         * top side rotate
         * */
        temp1 = up[0][0];
        up[0][0] = up[0][01];
        up[0][01] = up[01][01];
        up[01][01] = up[01][0];
        up[01][0] = temp1;

    }

    void U(){
        temp[0] = back[0][0];
        temp[1] = back[0][1];

        back[0][0] = left[0][0];
        back[0][1] = left[0][1];

        left[0][0]=front[0][0];
        left[0][01]=front[0][01];

        front[0][0]=right[0][0];
        front[0][01]=right[0][01];

        right[0][0]=temp[0];
        right[0][01]=temp[01];
        /**
         * top side rotate
         * */
        temp1 = up[0][0];
        up[0][0] = up[01][0];
        up[01][0] = up[01][01];
        up[01][01] = up[0][01];
        up[0][01] = temp1;

    }

    void D(){

        temp[0] = back[1][0];
        temp[1] = back[1][1];

        back[01][0] = right[01][0];
        back[01][1] = right[01][1];

        right[01][0]=front[01][0];
        right[01][01]=front[01][01];

        front[01][0]=left[01][0];
        front[01][01]=left[01][01];

        left[01][0]=temp[0];
        left[01][01]=temp[01];
        /**
         * down side rotate
         * */
        temp1 = down[0][0];
        down[0][0] = down[01][0];
        down[01][0] = down[01][01];
        down[01][01] = down[0][01];
        down[0][01] = temp1;


    }

    void Di(){

        temp[0] = back[01][0];
        temp[1] = back[01][1];

        back[01][0] = left[01][0];
        back[01][1] = left[01][1];

        left[01][0]=front[01][0];
        left[01][01]=front[01][01];

        front[01][0]=right[01][0];
        front[01][01]=right[01][01];

        right[01][0]=temp[0];
        right[01][01]=temp[01];
        /**
         * down side rotate
         * */

        temp1 = down[0][0];
        down[0][0] = down[0][01];
        down[0][01] = down[01][01];
        down[01][01] = down[01][0];
        down[01][0] = temp1;

    }

    void Li(){

        temp[0] = back[0][1];
        temp[1] = back[1][1];

        back[1][1]=up[0][0];
        back[0][1]=up[1][0];

        up[0][0]=front[0][0];
        up[01][0]=front[1][0];

        front[0][0]=down[0][0];
        front[1][0]=down[1][0];

        down[0][0] = temp[1];
        down[1][0] = temp[0];

        /*left side rotate*/
        temp1 = left[0][0];
        left[0][0] = left[0][1];
        left[0][1] = left[1][1];
        left[1][1] = left[1][0];
        left[1][0] = temp1;
    }

    void L(){

        temp[0] = back[0][1];
        temp[1] = back[1][1];

        back[1][1]=down[0][0];
        back[0][1]=down[1][0];

        down[0][0]=front[0][0];
        down[01][0]=front[1][0];

        front[0][0]=up[0][0];
        front[1][0]=up[1][0];

        up[0][0] = temp[1];
        up[1][0] = temp[0];

        /*left sode rotate*/

        temp1 = left[0][0];
        left[0][0] = left[1][0];
        left[1][0] = left[1][1];
        left[1][1] = left[0][1];
        left[0][1] = temp1;

    }

    void R(){

        temp[0] = back[0][0];
        temp[1] = back[1][0];

        back[0][0]=up[1][1];
        back[1][0]=up[0][01];

        up[0][01]=front[0][01];
        up[01][01]=front[1][01];

        front[0][01]=down[0][01];
        front[1][01]=down[1][01];

        down[0][01] = temp[1];
        down[1][01] = temp[0];
        /**
         * right side rotate*/
        temp1 = right[0][0];
        right[0][0] = right[1][0];
        right[1][0] = right[1][1];
        right[1][1] = right[0][1];
        right[0][1] = temp1;
    }

    void Ri(){
        temp[0] = back[0][0];
        temp[1] = back[1][0];

        back[0][0]=down[1][1];
        back[1][0]=down[0][1];

        down[0][01]=front[0][01];
        down[01][01]=front[1][01];

        front[0][01]=up[0][01];
        front[1][01]=up[1][01];

        up[0][01] = temp[1];
        up[1][01] = temp[0];
        /**
         * right side rotate*/
        temp1 = right[0][0];
        right[0][0] = right[0][1];
        right[0][1] = right[1][1];
        right[1][1] = right[1][0];
        right[1][0] = temp1;
    }

    void F(){

        temp[0] = up[1][0];
        temp[1] = up[1][1];

        up[1][0] = left[1][1];
        up[1][1] = left[0][1];

        left[0][1] = down[0][0];
        left[1][1] = down[0][1];

        down[0][0] = right[0][0];
        down[0][1] = right[1][0];

        right[0][0] = temp[0];
        right[1][0] = temp[1];

        /*front rotate*/
        temp1 = front[0][0];
        front[0][0] = front[1][0];
        front[1][0] = front[1][1];
        front[1][1] = front[0][1];
        front[0][1] = temp1;
    }

    void Fi(){

        temp[0] = up[1][0];
        temp[1] = up[1][1];

        up[1][0] = right[0][0];
        up[1][1] = right[1][0];

        right[0][0] = down[0][0];
        right[1][0] = down[0][1];

        down[0][0] = left[0][1];
        down[0][1] = left[1][1];

        left[0][1] = temp[0];
        left[1][1] = temp[1];

        /*front rotate*/
        temp1 = front[0][0];
        front[0][0] = front[0][1];
        front[0][1] = front[1][1];
        front[1][1] = front[1][0];
        front[1][0] = temp1;
    }

    void Bi(){

        temp[0] = up[0][0];
        temp[1] = up[0][1];

        up[0][0] = left[1][0];
        up[0][1] = left[0][0];

        left[0][0] = down[1][0];
        left[1][0] = down[1][1];

        down[1][0] = right[1][1];
        down[1][1] = right[0][1];

        right[1][1] = temp[1];
        right[0][1] = temp[0];

        /*back rotate*/
        temp1 = back[0][0];
        back[0][0] = back[0][1];
        back[0][1] = back[1][1];
        back[1][1] = back[1][0];
        back[1][0] = temp1;
    }

    void B(){

        temp[0] = up[0][0];
        temp[1] = up[0][1];

        up[0][0] = right[0][1];
        up[0][1] = right[01][01];

        right[0][01] = down[1][01];
        right[1][01] = down[1][0];

        down[1][0] = left[0][0];
        down[1][1] = left[1][0];

        left[0][0] = temp[1];
        left[1][0] = temp[0];

        /*back rotate*/
        temp1 = back[0][0];
        back[0][0] = back[1][0];
        back[1][0] = back[1][1];
        back[1][1] = back[0][1];
        back[0][1] = temp1;

    }

    void Printer(){
        System.out.println("  "+""+up[0][0]+""+up[0][1]);
        System.out.println("  "+""+up[01][0]+""+up[01][1]);
        System.out.println(""+left[0][0]+""+left[0][1]+""+front[0][0]+""+front[0][1]+""+right[0][0]+""+right[0][1]+""+back[0][0]+""+ back[0][1]);
        System.out.println(""+left[01][0]+""+left[01][1]+""+front[01][0]+""+front[01][1]+""+right[01][0]+""+right[01][1]+""+back[01][0]+""+back[01][1]);
        System.out.println("  "+""+down[0][0]+""+down[0][1]);
        System.out.println("  "+""+down[01][0]+""+down[01][1]);
        System.out.println("\n");
    }

    /**
     * update 2
     * Step 2: implement the moves by creating algorithms   OLL, PLL
     * */
    /*2x2x2 OLL test prototype*/

    void Sune(){/*(RURi) U (RU2Ri)*/R();U();Ri(); U(); R();U();U();Ri();}

    void AntiSune() /* (Ri Ui R) Ui (Ri U2i R)*/ {    Ri(); Ui(); R(); Ui(); Ri(); Ui(); Ui(); R();}

    void Headlights()   /* F U R Ui Ri Fi */ {      F();U(); R(); Ui(); Ri();Fi();  }
    void Chamelion()/* (R U Ri Ui) (Ri F R Fi) */ {   R(); U(); Ri(); Ui(); Ri(); F(); R(); Fi();}

    void DiagonalCorners()/* Fi (R U Ri Ui) Ri F R*/ {   Fi(); R(); U(); Ri(); Ui(); Ri(); F(); R();}

    void Symmetric()/* R2 U2 R U2 R2*/ { R();R(); U();U();R();U();U();R();R(); }

    void NonSymetric()/*F (R U Ri Ui)(R U Ri Ui ) Fi*/ { F();R();U();Ri();Ui(); R();U();Ri();Ui(); Fi();}

    /*2x2x2 PLL test prototype| U face only plls*/
    void Adjacent()/* (R U2 Ri Ui) (R U2) (Li U Ri Ui L)*/ {   R();U();U();Ri();Ui();R();U();U(); Li();U();Ri();Ui();L();  }

    void Diagonal()/*(R Ui Ri Ui F2 UI)(RURi)D R2*/ {R();Ui();Ri();Ui();F();F();Ui();R();U();Ri();D();R();R();}

    /*EXTRAs: U and D face PLL*/
    void BothDiagonal()/* r2 f2 r2*/ {   R();R();F();F();R();R();    }
    void U_AdjacentD_Diagonal()/*(r ui r) f2 (ri u ri)*/{   R();Ui();R(); F();F();Ri();U();Ri();    }

    //void BothAdjacent(){} //unimplementable due to lack of functions!!! :o
    /**
     * update 3
     * the case checkers
     * */
    void OLL(){
        //int GetColor;
        /** up , down, left, right, front, back*/
        //GetColor= up[1][0];
        if(back[0][1]==up[1][0] && right[0][1] == up[1][0] && front[0][1] == up[1][0]) {
            Sune();
        }else if(up[0][0] == back[0][0] && up[0][0]== right[0][0] && up[0][0]==front[0][0]){
            AntiSune();
        }else if(up[0][0] == up[1][0] && up[0][0] == right[0][0] && up[0][0] == right[0][1]){
            Headlights();
        }else if(up[0][1] == up[1][1] && back[0][1] == up[1][1] && front[0][0] == up[1][1]){
            Chamelion();
        }else if(up[0][1] == up[1][0] && left[0][0] == up[0][1] && front[0][1] == up[1][0]){
            DiagonalCorners();
        }else if(front[0][0] == front[0][1] && back[0][0] == back[0][1] && front[0][0] == back[0][0]){
            Symmetric();
        }else if(left[0][0] == left[0][1] && back[0][0] == front[0][1] && front[0][1] == left[0][0]){
            NonSymetric();
        }else{      System.out.println("Error! No cases of the OLL matches! :o");   }
    }
    void PLL(){
        /**ami asolei bujhtesi na j kokhon Adjacent, kokhon diagonal use korbo! :o*/
    }
    void InputViaFile(String s){
        System.out.println(s.length());
        System.out.println(s);
        for(int i=0; i<24; i++)
            System.out.print(s.charAt(i));
        System.out.println();
        up[0][0] = s.charAt(0);
        up[0][1] = s.charAt(1);
        up[1][0] = s.charAt(2);
        up[1][1] = s.charAt(3);

        down[0][0] = s.charAt(4);
        down[0][1] = s.charAt(5);
        down[1][0] = s.charAt(6);
        down[1][1] = s.charAt(7);

        left[0][0] = s.charAt(8);
        left[0][1] = s.charAt(9);
        left[1][0] = s.charAt(10);
        left[1][1] = s.charAt(11);

        right[0][0] = s.charAt(12);
        right[0][1] = s.charAt(13);
        right[1][0] = s.charAt(14);
        right[1][1] = s.charAt(15);

        front[0][0] = s.charAt(16);
        front[0][1] = s.charAt(17);
        front[1][0] = s.charAt(18);
        front[1][1] = s.charAt(19);

        back[0][0] = s.charAt(20);
        back[0][1] = s.charAt(21);
        back[1][0] = s.charAt(22);
        back[1][1] = s.charAt(23);


    }


}
