import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        try {
           int frameNum = Integer.parseInt(args[0]);
           //int frameNum = 10;

            //Initialize page table array to have space equal to the passed in number of frames
            int[] LRU = new int[frameNum];
            int[] lruTimeTable = new int[frameNum];
            int[] FIFO = new int[frameNum];
            int[] Optimal = new int[frameNum];
            int[] Random = new int[frameNum];

            //Map page replacement types to an array holding total page faults and total pages for each reference string
            HashMap<int[], ArrayList<RefStringValues>> typeMap = new HashMap<>();
            typeMap.put(LRU, new ArrayList<>());
            typeMap.put(FIFO, new ArrayList<>());
            typeMap.put(Optimal, new ArrayList<>());
            typeMap.put(Random, new ArrayList<>());

            //Fill al page tables with -1 since a page can have a value of 0 and arrays are initialize with 0
            for (int[] key: typeMap.keySet()) {
                Arrays.fill(key, -1);
            }

            // Read in the reference strings from the dat file
            File in = new File("reference-strings.dat");
            Scanner scnr = new Scanner(in);

            int refCount = 0;
            while(scnr.hasNextLine()){
                System.out.println("Reference String: ".concat(Integer.toString(refCount + 1)));

                //Split string based on whitespace since page values are separated by the whitespace in the file
                String line = scnr.nextLine();
                String[] input = line.split(" ");

                //Add new counter for next reference string of values
                for (int[] key: typeMap.keySet()) {
                    typeMap.get(key).add(new RefStringValues());
                }

                int fifoIter = 0;
                int lruTime = 1;
                ArrayList<Integer> pageList = new ArrayList<>();

                for (String page: input) {
                    pageList.add(Integer.parseInt(page));
                }

                for (String page: input) {
                    int p = Integer.parseInt(page);

                    //Replacement algorithm for FIFO
                    if(!contains(FIFO, p)){

                        //Will go through in a circular motion replacing the oldest page
                        FIFO[fifoIter] = p;
                        fifoIter = (fifoIter + 1) % frameNum;
                        typeMap.get(FIFO).get(refCount).incFault();
                    }

                    //Replacement algorithm for LRU
                    if(!contains(LRU, p)){

                        //Uses a time table to find which page was placed or accessed last
                        int min = Integer.MAX_VALUE;
                        int curInd = 0;

                        for(int i = 0; i < lruTimeTable.length; i++){
                            if(min > lruTimeTable[i]){
                                curInd = i;
                                min = lruTimeTable[i];
                            }
                        }
                        LRU[curInd] = p;
                        lruTimeTable[curInd] = lruTime;
                        typeMap.get(LRU).get(refCount).incFault();
                    }else{
                        for(int i = 0; i < LRU.length; i++){
                            if(LRU[i] == p){
                                lruTimeTable[i] = lruTime;
                                break;
                            }
                        }
                    }

                    //Replacement algorithm for Optimal
                    if(!contains(Optimal, p)){

                        //Finds the page that will be needed last, since lruTime will always be a spot ahead of the current
                        //page, it will be used for the starting point of the search
                        int longest = -1;
                        int curInd = 0;
                        for(int i = 0; i < Optimal.length; i++){
                            if(Optimal[i] == -1){
                                curInd = i;
                                break;
                            }

                            boolean found = false;
                            for(int j = lruTime; j < pageList.size(); j++){
                                if(pageList.get(j) == Optimal[i]){
                                    if(longest < j){
                                        longest = j;
                                        curInd = i;
                                    }
                                    found = true;
                                    break;
                                }
                            }

                            if(!found){
                                curInd = i;
                                break;
                            }
                        }

                        Optimal[curInd] = p;
                        typeMap.get(Optimal).get(refCount).incFault();
                    }

                    //Replacement algorithm for random
                    if(!contains(Random, p)){
                        int curInd = (int) (Math.random() * frameNum);
                        Random[curInd] = p;
                        typeMap.get(Random).get(refCount).incFault();
                    }

                    //Increment total of all reference string counters
                    for (int[] key: typeMap.keySet()) {
                        typeMap.get(key).get(refCount).incTotal();
                    }

                    lruTime++;
                }

                //Print calculated values for current reference string
                System.out.println("FIFO: " + typeMap.get(FIFO).get(refCount).toString());
                System.out.println("LRU: " + typeMap.get(LRU).get(refCount).toString());
                System.out.println("Optimal: " + typeMap.get(Optimal).get(refCount).toString());
                System.out.println("Random: " + typeMap.get(Random).get(refCount).toString());
                System.out.println();

                //Reset all arrays being used
                for (int[] key: typeMap.keySet()) {
                    Arrays.fill(key, -1);
                }
                Arrays.fill(lruTimeTable, 0);

                refCount++;
            }

            System.out.println("Total: ");
            //Print total values across all reference strings
            printTotals("FIFO", typeMap.get(FIFO));
            printTotals("LRU",  typeMap.get(LRU));
            printTotals("Optimal",  typeMap.get(Optimal));
            printTotals("Random",  typeMap.get(Random));

        }catch (Exception e){

        }
    }

    //Checks if an array contains a given value
    static public boolean contains(int[] arr, int e){

        for (int i: arr) {
            if(i == e){
                return true;
            }
        }

        return false;
    }

    //Prints formated total values of all the reference string objects
    static public void printTotals(String name, ArrayList<RefStringValues> refs){
        int total = 0;
        int faults = 0;

        for(RefStringValues ref: refs){
            total += ref.getTotal();
            faults += ref.getFaults();
        }

        System.out.println(name + ": " + " Faults: " + faults + " Total: " + total);
    }
}
