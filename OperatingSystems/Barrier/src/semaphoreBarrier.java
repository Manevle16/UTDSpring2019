import java.util.concurrent.Semaphore;

public class semaphoreBarrier implements Barrier
{
	private final Semaphore available = new Semaphore(1, true);
	private final Semaphore barrier = new Semaphore(0, true);
	private int numOfThreads = 0;
	private int atBarrier = 0;

	public semaphoreBarrier(int N)
	{
        numOfThreads = N;
	}
	public void arriveAndWait()
	{
        try
        {

            available.acquire();

        }catch(Exception e){
            System.out.println(e);
            System.exit(1);
        }
       // System.out.println(atBarrier);
        if(++atBarrier != numOfThreads)
        {
            //System.out.println("At Barrier: " + atBarrier);
            available.release();
            try {
                barrier.acquire();
            } catch (Exception e) {
                System.out.println(e);
                System.exit(1);
            }
        }

        if(--atBarrier == 0){
            available.release();
        }else{
            barrier.release();
        }
	}
}






