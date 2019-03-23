public class monitorBarrier implements Barrier
{
	private int barrier = 0;
	private boolean barrierEmpty = true;
	private boolean passedBarrier = false;
	private int numOfThreads = 0;

	public monitorBarrier(int n)
	{
		numOfThreads = n;
	}

	public synchronized void arriveAndWait()
	{
		if (!barrierEmpty) //Make sure the barrier is completely cleared out before reusing it.
		{
			try
			{
				wait();
			} catch (InterruptedException e)
			{
				System.out.println("error waiting.");
				e.printStackTrace();
			}
		}
		if(passedBarrier) //Will wake up all threads that are waiting for the barrier to be empty, should only get here when the barrier is empty AND a barrier just finished.
		{
			notifyAll();
		}
		passedBarrier = false; //Makes sure notify all from previous is only triggered by one thread.
		barrier++;
		if (barrier < numOfThreads) //Waiting until all threads have entered then the last thread will notify all the others to wake up.
		{
			try
			{
				wait();
			} catch (InterruptedException e)
			{
				System.out.println("error waiting.");
				e.printStackTrace();
			}
		}
		else
		{
			notifyAll();
		}
		passedBarrier = true;
		barrier--;
		if (barrier > 0)
		{
			barrierEmpty = false;
		}
		else
		{
			barrierEmpty = true;
		}
	}
}

