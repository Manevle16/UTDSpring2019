import java.util.Vector;

public class Main {

    public static void main(String[] args) {
        Node a = new Node('a');
        Node b = new Node('b');
        Node c = new Node('c');
        Node d = new Node('d');
        Node e = new Node('e');
        Node f = new Node('f');
        Node g = new Node('g');
        Node h = new Node('h');
        Node i = new Node('i');

        Graph graph = new Graph();
        graph.addNode(a);
        graph.addNode(b);
        graph.addNode(c);
        graph.addNode(d);
        graph.addNode(e);
        graph.addNode(f);
        graph.addNode(g);
        graph.addNode(h);
        graph.addNode(i);

        Edge one = new Edge(a, b, 2);
        Edge two = new Edge(a, d, 2);
        Edge three = new Edge(b, c, 2);
        Edge four = new Edge(d, c, 2);
        Edge five = new Edge(b, e, 2);
        Edge six = new Edge(c, e, 2);
        Edge seven = new Edge(c, g, 3);
        Edge eight = new Edge(g, f, 3);
        Edge nine = new Edge(e, f, 3);
        Edge ten = new Edge(e, h, 2);
        Edge eleven = new Edge(b, i, 2);
        Edge twelve = new Edge(i, h, 2);


        graph.addEdge(one);
        graph.addEdge(two);
        graph.addEdge(three);
        graph.addEdge(four);
        graph.addEdge(five);
        graph.addEdge(six);
        graph.addEdge(seven);
        graph.addEdge(eight);
        graph.addEdge(nine);
        graph.addEdge(ten);
        graph.addEdge(eleven);
        graph.addEdge(twelve);

        Vector<Node> adj = graph.getAdjacent(a);

        for (Node n: adj) {
            System.out.print(n.getId() + " ");
        }

        for(Node key: graph.getAdjacent().keySet()){
            key.setVisited(true);
            DFS()


        }



    }
}

