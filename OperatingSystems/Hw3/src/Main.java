import java.util.Arrays;
import java.util.Vector;


public class Main {

    static public int[] ThreadHandler(int start, int end, int k, int numThreads){
        int[] amounts = new int[end-start+1];

        int[] bestNums = new int[k];
        Arrays.fill(bestNums, -1);

        int iter = (int)Math.ceil((end - start)/numThreads);
        Vector<Thread> threads = new Vector<Thread>();

        int newStart = start;
        for(int i = 0; i < numThreads; i++){
            Thread t;
            if(newStart + iter <= end) {
                t = new Thread(new LargestDivisors(start, amounts, newStart, newStart + iter));
            }else if(newStart <= end){
                t = new Thread(new LargestDivisors(start, amounts, newStart, end));
            }else{
                break;
            }
            newStart = newStart + iter + 1;
            t.setName(Integer.toString(i));
            t.start();
            threads.add(t);

        }

        for(int i = 0; i < threads.size(); i++){
            try {
                threads.get(i).join();
            }catch (InterruptedException e){
                System.out.println(e);
            }
        }

        int min = Integer.MIN_VALUE;
        int minInd = 0;
        for(int i = 0; i < amounts.length; i++){
            if(k > 0){
                bestNums[i] = start + i;
                if(amounts[i] < min){
                    min = amounts[i];
                    minInd = i;
                }
                k--;
            }else{
                if(amounts[i] > min){
                    bestNums[minInd] = start + i;
                    min = amounts[i];
                    for(int j = 0; j < bestNums.length; j++){
                        if(amounts[bestNums[j] - start] < min){
                            min = amounts[bestNums[j] - start];
                            minInd = j;
                        }
                    }
                }
            }
        }

        return bestNums;
    }

    public static void main(String[] args) {
        long startTime = System.nanoTime();
        int start = Integer.parseInt(args[0]);
        int end = Integer.parseInt(args[1]);
        int k = Integer.parseInt(args[2]);
        int numThreads = Integer.parseInt(args[3]);
        int[] ans = ThreadHandler(start, end, k, numThreads);

        for(int i = 0; i < ans.length; i++){
            if(ans[i] != -1)
                System.out.print(ans[i] + " ");
        }
        System.out.println("");
        long endTime   = System.nanoTime();
        long totalTime = endTime - startTime;
        System.out.println((double)totalTime/ 1000000000 + " seconds elapsed");
    }
}
