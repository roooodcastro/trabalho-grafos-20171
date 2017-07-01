# The implementation of the Dijkstra algorithm
class Dijkstra
  attr_reader :graph, :root_vertex, :distances

  # Class constructor. Initializes it with a graph and picks a random vertex
  # to be the root.
  def initialize(graph)
    @graph = graph
    @root_vertex = graph.vertices.sample
    @distances = {}
  end

  def run
    queue = initialize_dijkstra

    while queue.present? do
      min_node = queue.extract_minimum
      min_node.edges.each do |edge|
        neighbour = edge.other_vertex(min_node)
        try_to_change_previous(neighbour, min_node, edge.length, queue)
      end
    end
  end

  def initialize_dijkstra
    root_vertex.distance = 0
    queue = PriorityQueue.new
    graph.vertices.each do |vertex|
      vertex.distance = Float::INFINITY unless vertex == root_vertex
      graph.vertices[vertex.id].previous = nil
      queue.insert(vertex)
    end
    queue
  end

  def try_to_change_previous(vertex, possible_previous, distance, queue)
    new_distance = possible_previous.distance + distance
    if new_distance < vertex.distance
      vertex.previous.next_vertices.delete(vertex) if vertex.previous
      vertex.previous = possible_previous
      possible_previous.next_vertices << vertex
      queue.decrease_distance(vertex, new_distance)
    end
  end
end
