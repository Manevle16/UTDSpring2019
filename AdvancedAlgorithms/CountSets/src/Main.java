import java.util.Arrays;
import java.util.Vector;

public class Main {

    public static void main(String[] args) {
        int[] range = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
        int[] div = {2, 3, 5, 7};


        int max = 0;
        for(int i = 0; i < range.length; i++){
            System.out.print(range[i] + " ");
            if(range[i] > max){
                max = range[i];
            }
        }
        System.out.println("");

        int count = 0;
        int curMult = 1;
        int j = 0;

        int[] newDiv = new int[div.length];
        Arrays.fill(newDiv, 1);

        while( j < range.length){

            int min = Integer.MAX_VALUE;
            for(int i = 0; i < newDiv.length; i++){
                if(newDiv[i] * div[i] < min){
                    min = newDiv[i] * div[i];
                }
            }

            curMult = min;

            while(j < range.length && curMult > range[j]){
                j++;
            }

            if(range[j] == curMult){
                count++;
                j++;
            }


            for(int i = 0; i  < newDiv.length; i++){
                if(curMult == newDiv[i] * div[i]){

                    newDiv[i] += 1;
                    break;
                }
            }
        }
        System.out.println(count);
    }
}
