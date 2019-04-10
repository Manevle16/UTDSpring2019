public class Edge {
    private Node node1;
    private Node node2;
    private int weight;

    public Edge(Node n1, Node n2, int w){
        node1 = n1;
        node2 = n2;
        weight = w;
    }

    public Node getNode1() {
        return node1;
    }

    public Node getNode2() {
        return node2;
    }

    public int getWeight() {
        return weight;
    }
}
