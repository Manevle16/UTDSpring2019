import java.util.Arrays;
import java.util.Vector;
import java.util.concurrent.atomic.AtomicInteger;

public class Main {

    static public int[] ThreadHandler(int start, int end, AtomicInteger k, int numThreads){
        int[] amounts = new int[end-start+1];

        int[] bestNums = new int[k.get()];
        Arrays.fill(bestNums, 0);

        int iter = (int)Math.ceil((start - end)/numThreads);

        Vector<Thread> threads = new Vector<Thread>();

        int newStart = start;
        for(int i = 0; i < numThreads; i++){
            Thread t;
            if(newStart + i*iter <= end) {
                t = new Thread(new LargestDivisors(start, amounts, newStart, newStart + i * iter));
            }else if((int)Math.ceil(((start - end + 1))/numThreads) % numThreads != 0 && newStart + i*iter - 1 <= end){
                t = new Thread(new LargestDivisors(start, amounts, newStart, newStart + i * iter - 1));
            }else{
                break;
            }
            newStart = newStart + i * iter + 1;
            t.setName(Integer.toString(i));
            t.start();
            threads.add(t);
        }

        for(int i = 0; i < numThreads; i++){
            try {
                threads.get(i).join();
            }catch (InterruptedException e){
                System.out.println(e);
            }
        }

        return bestNums;
    }

    public static void main(String[] args) {
        int start = Integer.parseInt(args[0]);
        int end = Integer.parseInt(args[1]);
        AtomicInteger k = new AtomicInteger(Integer.parseInt(args[2]));
        int numThreads = Integer.parseInt(args[3]);

        int[] ans = ThreadHandler(start, end, k, numThreads);

        for(int i = 0; i < ans.length; i++){
            System.out.print(ans[i] + " ");
        }
    }
}
