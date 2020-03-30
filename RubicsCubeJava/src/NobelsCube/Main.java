package NobelsCube;
import java.util.Scanner;

public class Main {
    /**@param args the command line arguments*/
    static int[] u = new int[4];
    static int[] d = new int[4];
    static int[] l = new int[4];
    static int[] r = new int[4];
    static int[] f = new int[4];
    static int[] b = new int[4];
    
    static char[] moves = new char[1000];
    static int movesPos = 0;

    static final int YELLOW = 1;
    static final int WHITE  = -1;
    static final int ORANGE = +2;
    static final int RED    = -2;
    static final int BLUE   = +3;
    static final int GREEN  = -3;
    
    public static void main(String[] args) {
        takeInputs();
        
        //Placing the first corner.
        //Returns false if not placed.
        boolean isCorner1PlacedCorrectly = placeCorner1();
        //if (isCorner1PlacedCorrectly) {firstLayerCorners[3] = true;}

        //Tries to place another corner
		placeAnotherCorner();
		placeAnotherCorner();
		placeAnotherCorner();

		System.out.print("OLL - ");
		doOLL();
		System.out.print("PLL - ");
		doPLL();
		
		showMoves();
        printer();

    }

    static void printer(){
        for(int i=0; i<4; i++){
            System.out.print(u[i]);
        }
        System.out.println("");
        for(int i=0; i<4; i++){
            System.out.print(l[i]);
        }
        System.out.println("");
        for(int i=0; i<4; i++){
            System.out.print(f[i]);
        }
        System.out.println("");
        for(int i=0; i<4; i++){
            System.out.print(r[i]);
        }
        System.out.println("");
        for(int i=0; i<4; i++){
            System.out.print(b[i]);
        }
        System.out.println("");
        for(int i=0; i<4; i++){
            System.out.print(d[i]);
        }
        System.out.println("");
    }

    static boolean placeCorner1 () {
        boolean temp = placeCorner1FromUpperSide();
        if (!temp) {
            movR();
            movR();
            movL();
            movL();
            temp = placeCorner1FromUpperSide();
        }
        return temp;
    }
    static boolean placeCorner1FromUpperSide () {
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
        //unnecessary 4 U moves, so--
        movesPos -= 4;
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
        //unnecessary 4 U moves, so--
        movesPos -= 4;
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
        //unnecessary 4 U moves, so--
        movesPos -= 4;
        return false;
    }
    static boolean placeAnotherCorner () {
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
		//unnecessary 4 U moves, so--
        movesPos -= 4;
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
		//unnecessary 4 U moves, so--
        movesPos -= 4;
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
                    movU();
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
                    movU();
                    movR();
                    return true;
                }
            }
            else {movU();}
        }
		//unnecessary 4 U moves, so--
        movesPos -= 4;
        //search in down side
		
        return false;
    }
	
	//the following function is not applied.
	static int bringUpFromDownSide () {
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
    static boolean placeAnotherCornerFromDownSide () {
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
    
	static boolean doOLL() {
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
			return true;
		}
		return false;
	}
	static boolean doPLL() {
		//first look for adjacent
		for (int i=0 ; i<4 ; i++) {
			if (l[0]==l[1]) {
				if (r[0]==r[1]) {
					return true; //PLL skip!
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
		//unnecessary 4 U moves, so--
        movesPos -= 4;
		//and as still not returned, it must be diagonal case
		System.out.println("diagonal");
		movR();movUi();movRi();movUi();movF();
		movF();movUi();movR();movU();movRi();
		movD();movR();movR();
		//finish through Ups!
		while (f[0]!=f[3]) {movU();	}
		return true;
	}
	
    static void movU () {
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
    static void movUi () {
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
    static void movD () {
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
    static void movDi () {
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
    static void movL () {
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
    static void movLi () {
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
    static void movR () {
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
    static void movRi () {
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
    static void movF () {
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
    static void movFi () {
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
    static void movB () {
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
    static void movBi () {
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
    
    static void showMoves() {
        for (int i=0 ; i<movesPos ; i++) {
            System.out.print(moves[i] + " ");
        }
        System.out.println();
    }

	private static void takeInputs() {
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
				case 'g':
					u[i] = 3;
					break;
				case 'b':
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
				case 'g':
					l[i] = 3;
					break;
				case 'b':
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
				case 'g':
					f[i] = 3;
					break;
				case 'b':
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
				case 'g':
					r[i] = 3;
					break;
				case 'b':
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
				case 'g':
					b[i] = 3;
					break;
				case 'b':
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
				case 'g':
					d[i] = 3;
					break;
				case 'b':
					d[i] = -3;
					break;
				default:
					i--;
					break;
			}
		}
	}
}
