package rubicscube1;

import java.io.*;

public class Main {

    public static void main(String[] args) throws IOException {
	// write your code here
        cube1 cube = new cube1();
        System.out.println("original");
        cube.Printer();

        cube.U();
        System.out.println("U \n");
        cube.Printer();



        cube.D();
        System.out.println("D \n");
        cube.Printer();



        cube.L();
        System.out.println("L \n");
        cube.Printer();



        cube.R();
        System.out.println("Ri\n");
        cube.Printer();



        cube.F();
        System.out.println("F\n");
        cube.Printer();



        cube.B();
        System.out.println("B\n");
        cube.Printer();
        /**
         *
         * */
        cube.Bi();
        System.out.println("Bi\n");
        cube.Printer();

        cube.Fi();
        System.out.println("Fi\n");
        cube.Printer();

        cube.Ri();
        System.out.println("R\n");
        cube.Printer();

        cube.Li();
        System.out.println("Li\n");
        cube.Printer();

        cube.Di();
        System.out.println("Di\n");
        cube.Printer();

        cube.Ui();
        System.out.println("Ui \n");
        cube.Printer();
        /**taking input using file IO*/
        String  s="";
        int k=0;
        String s1 ="";
        //s = new char[30];
        String source = "src\\rubicscube1\\input.txt";
        File f = new File(source);
        FileReader fr = new FileReader(f);
        BufferedReader br = new BufferedReader(fr);
        int j=0;
        while(true){

            s = br.readLine();
            if(s==null) break;
            s1 = s1+s;
        }

        br.close();
        fr.close();
        /* vul hoise/ kaj kore na! :'(
        InputStream in = new FileInputStream(source);
        while(true){
            int c = in.read();
            if(c==-1) break;
            //s[k] = (char)c;
            //k++;
            String s1 = ""+(char)c;
            if(s1.equals("\n")){continue;}
            else{s = s+(char)c;}

        }
        in.close();
*/      /**
         * OLL testing:
         * Successfull: sune, antisune, chameleon, Symmetric, NonSymmetric
         * Unseccessfull: headlight,diagonal corners
         * */
        cube.InputViaFile(s1);
        cube.Printer();
        cube.OLL();
        cube.Printer();
    }
}
