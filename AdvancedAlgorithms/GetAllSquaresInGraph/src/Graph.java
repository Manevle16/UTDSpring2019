import java.util.HashMap;
import java.util.Vector;

public class Graph {

    private Vector<Node> nodes = new Vector<Node>();
    private Vector<Edge> edges = new Vector<Edge>();
    private HashMap<Node, Vector<Node>> adjacent = new HashMap<>();


    public void addEdge(Edge e){
        edges.add(e);
        if(!adjacent.containsKey(e.getNode1()))
            adjacent.put(e.getNode1(), new Vector<>());
        if(!adjacent.containsKey(e.getNode2()))
            adjacent.put(e.getNode2(), new Vector<>());
        adjacent.get(e.getNode1()).add(e.getNode2());
        adjacent.get(e.getNode2()).add(e.getNode1());
    }

    public Edge getEdge(Node n1, Node n2){
        for(int i = 0; i < edges.size(); i++){
            if((edges.get(i).getNode1() == n1 && edges.get(i).getNode2() == n2) || (edges.get(i).getNode2() == n1 && edges.get(i).getNode1() == n2)){
                return edges.get(i);
            }
        }

        return null;
    }

    public void addNode(Node n){
        nodes.add(n);
    }

    public Vector<Node> getAdjacent(Node n){
        return adjacent.get(n);
    }

    public HashMap<Node, Vector<Node>> getAdjacent() {
        return adjacent;
    }
}
