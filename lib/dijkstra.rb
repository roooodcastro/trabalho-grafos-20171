# The implementation of the Dijkstra algorithm
class Dijkstra
  attr_reader :graph, :root_vertex

  # Class constructor. Initializes it with a graph and picks a random vertex
  # to be the root.
  def initialize(graph)
    @graph = graph
    @root_vertex = graph.vertices.sample
  end

  def run
    distances = {}
    previous = {}
    distances[root_vertex] = 0

    queue = PriorityQueue.new

    graph.vertices.each do |vertex|
      next if vertex == root_vertex
      distances[vertex] = Float::INFINITY
      previous[vertex] = nil

      queue.add_with_priority(vertex, distances[vertex])

      while queue.empty do
        u = queue.extract_min
        e.neighbours.each do
          alt = distances[u] + length(u, vertex)
          if alt < distances[vertex]
            distances[vertex] = alt
            prev[vertex] = u
            queue.decrease_priority(vertex, alt)

            return distances[], prev[]
          end
        end
      end
    end
  end
end
