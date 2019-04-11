public class Node {
    private char id;
    private boolean visited = false;
    private boolean marked = false;

    public Node(char id){
        this.id = id;
    }

    public char getId() {
        return id;
    }

    public boolean isMarked() {
        return marked;
    }

    public boolean isVisited() {
        return visited;
    }

    public boolean isMarkedOrVisited(){
        return marked || visited;
    }

    public void setVisited(boolean visited) {
        this.visited = visited;
    }

    public void setMarked(boolean marked) {
        this.marked = marked;
    }
}
