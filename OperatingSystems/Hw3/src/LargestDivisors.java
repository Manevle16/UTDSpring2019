import java.util.Arrays;


public class LargestDivisors implements Runnable {

    private int start;
    private int rangeStart;
    private int rangeEnd;
    private int[] amounts;

    public LargestDivisors(int a, int[] amounts, int rangeStart, int rangeEnd){
        start = a;
        this.rangeStart = rangeStart;
        this.rangeEnd = rangeEnd;
        this.amounts = amounts;
    }

    public void run(){
        for(int j = rangeStart; j <= rangeEnd; j++) {
            int numDiv = 2;
            for (int i = j - 1; i > 1; i--) {
                if (j % i == 0) {
                    numDiv += 1;
                }
            }

            int spot = j - start;
            amounts[spot] = numDiv;
        }
    }

}
