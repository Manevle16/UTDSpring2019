public class Main {

    public static void main(String[] args) {
        int[] range = {1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
        int[] div = {2, 3, 5};


        for(int i = 0; i < range.length; i++){
            System.out.print(range[i] + " ");
        }
        System.out.println("");

        int count = 0;
        for(int i = 0; i < range.length; i++){
            for(int j = 0; j < div.length; j++){
                if(range[i] % div[j] == 0){
                    count++;
                    break;
                }
            }
        }

        System.out.println(count);
    }
}
