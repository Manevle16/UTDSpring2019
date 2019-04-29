//Holds computed values for each reference string
public class RefStringValues {
    private int faults = 0;
    private int total = 0;

    public int getFaults() {
        return faults;
    }

    public int getTotal() {
        return total;
    }

    public void incFault() {
        faults++;
    }

    public void incTotal() {
        total++;
    }

    @Override
    public String toString() {
        return "Faults: " + faults + " Total: " + total;
    }
}
