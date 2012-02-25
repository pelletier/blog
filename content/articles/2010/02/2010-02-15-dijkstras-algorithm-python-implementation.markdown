--- 
title: Dijkstra's algorithm Python implementation
---

Here is my implementation of Dijkstra's algorithm (also known as the shortest
path) in Python. I wrote it for a project at school and put it there for memory
only.

Note:

* I don't test the graph.
* Graph is oriented. If you want a non-oriented graph, you need to add vertices twice in your graph.
* May be improved (time).

Here is the source ([on Friendpaste](http://friendpaste.com/7ml2pWDYzgr0I0ZOiTU6nq)):

~~~ python
def dijkstra(graph, start, end):
    """
    Dijkstra's algorithm Python implementation.

    Arguments:
        graph: Dictionnary of dictionnary (keys are vertices).
        start: Start vertex.
        end: End vertex.

    Output:
        List of vertices from the beggining to the end.
    
    Example:
    
    >>> graph = {
    ...     'A': {'B': 10, 'D': 4, 'F': 10},
    ...     'B': {'E': 5, 'J': 10, 'I': 17},
    ...     'C': {'A': 4, 'D': 10, 'E': 16},
    ...     'D': {'F': 12, 'G': 21},
    ...     'E': {'G': 4},
    ...     'F': {'H': 3},
    ...     'G': {'J': 3},
    ...     'H': {'G': 3, 'J': 5},
    ...     'I': {},
    ...     'J': {'I': 8},
    ... }    
    >>> dijkstra(graph, 'C', 'I')
    ['C', 'A', 'B', 'I']

    """

    D = {} # Final distances dict
    P = {} # Predecessor dict

    # Fill the dicts with default values
    for node in graph.keys():
        D[node] = -1 # Vertices are unreachable
        P[node] = "" # Vertices have no predecessors
    
    D[start] = 0 # The start vertex needs no move

    unseen_nodes = graph.keys() # All nodes are unseen

    while len(unseen_nodes) > 0:
        # Select the node with the lowest value in D (final distance)
        shortest = None
        node = ''
        for temp_node in unseen_nodes:
            if shortest == None:
                shortest = D[temp_node]
                node = temp_node
            elif D[temp_node] < shortest:
                shortest = D[temp_node]
                node = temp_node
            
        # Remove the selected node from unseen_nodes
        unseen_nodes.remove(node)
    
        # For each child (ie: connected vertex) of the current node
        for child_node, child_value in graph[node].items():
            if D[child_node] < D[node] + child_value:
                D[child_node] = D[node] + child_value
                # To go to child_node, you have to go through node
                P[child_node] = node
            
    # Set a clean path
    path = []

    # We begin from the end
    node = end
    # While we are not arrived at the beginning
    while not (node == start):
        if path.count(node) == 0:
            path.insert(0, node) # Insert the predecessor of the current node
            node = P[node] # The current node becomes its predecessor
        else:
            break

    path.insert(0, start) # Finally, insert the start vertex
    return path
~~~
