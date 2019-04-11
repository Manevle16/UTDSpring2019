import java.security.Key;
import java.util.Vector;

public class Main {

    static int squareCount = 0;

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
        Node k = new Node('k');
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
        graph.addNode(k);

        Edge one = new Edge(a, b, 2);
        Edge two = new Edge(a, d, 2);
        Edge three = new Edge(b, c, 2);
        Edge four = new Edge(d, c, 2);
        Edge five = new Edge(b, k, 2);
        Edge six = new Edge(c, e, 2);
        Edge seven = new Edge(c, g, 2);
        Edge eight = new Edge(g, f, 2);
        Edge nine = new Edge(e, f, 2);
        Edge ten = new Edge(k, h, 2);
        Edge eleven = new Edge(b, i, 2);
        Edge twelve = new Edge(i, h, 2);
        Edge thirteen = new Edge(e, k, 2);


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
        graph.addEdge(thirteen);

        Vector<Node> adj = graph.getAdjacent(e);

        for (Node n: adj) {
            System.out.print(n.getId() + " ");
        }

        for(Node key: graph.getAdjacent().keySet()){
            System.out.println("Key: " + key.getId());
            key.setVisited(true);
            DFS(graph, key,  key, null, 0);

            for(int j = 0; j < graph.getNodes().size(); j++){
                graph.getNodes().get(j).setMarked(false);
            }

        }

        System.out.println(squareCount);
    }

    static public void DFS(Graph graph, Node key, Node curNode, Integer weight, int count){
        System.out.println("Count: " + count);
        Vector<Node> setMarked = new Vector<>();
        for(int j = 0; j < graph.getAdjacent(curNode).size(); j++){
            if(!graph.getAdjacent(curNode).get(j).isMarkedOrVisited() && (weight == null || weight == graph.getEdge(graph.getAdjacent(curNode).get(j), curNode).getWeight())){
                if(weight == null) {
                    weight = graph.getEdge(graph.getAdjacent(curNode).get(j), curNode).getWeight();
                }
                if(count == 3){
                    continue;
                }
                System.out.println("CurNode: " +  graph.getAdjacent(curNode).get(j).getId());
                setMarked.add(graph.getAdjacent(curNode).get(j));
                graph.getAdjacent(curNode).get(j).setMarked(true);
                DFS(graph, key, graph.getAdjacent(curNode).get(j), weight, count + 1);
            }else if(count == 3 && graph.getAdjacent(curNode).get(j) == key && weight == graph.getEdge(graph.getAdjacent(curNode).get(j), curNode).getWeight()){
                System.out.println("Found one: " + key.getId() + " " + curNode.getId());
                squareCount++;
            }
        }

        for(int j = 0; j < setMarked.size(); j++){
            setMarked.get(j).setMarked(false);
        }
        System.out.println("Returning");
    }
}

