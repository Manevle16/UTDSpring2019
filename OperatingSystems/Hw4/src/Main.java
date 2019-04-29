import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;

public class Main {

    public static void main(String[] args) {
        try {
         //   int frameNum = Integer.parseInt(args[0]);
            int frameNum = 10;
            int[] LRU = new int[frameNum];
            int[] FIFO = new int[frameNum];
            int[] Optimal = new int[frameNum];
            int[] Random = new int[frameNum];
            HashMap<int[], >

            // Read in the reference strings from the dat file
            InputStream in = new FileInputStream("reference-strings.dat");
            Reader r = new InputStreamReader(in, "US-ASCII");
            int intch;
            String input = "";
            while ((intch = r.read()) != -1) {
                char ch = (char) intch;
                if(ch == ' ' ){
                    System.out.println(input);
                    input = "";
                }else if( ch == '\n') {
                    System.out.println(input);
                    input = "";
                    break;
                }else{
                    input = input.concat(Character.toString(ch));
                }
            }
        }catch (Exception e){

        }
    }
}
