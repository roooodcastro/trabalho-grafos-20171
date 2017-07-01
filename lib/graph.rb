# A graph implementation
class Graph
  attr_reader :vertices, :edges

  # Limits the floating point precision to 6 decimal places (no need for more)
  FLOAT_PRECISION = 6

  # Static (class) methods
  class << self
    # Created and returns a new graph consisting of {nmum_vertices} vertices.
    # All of the vertices will be connected to each other, as specified in the
    # problem description.
    def create_random_graph(num_vertices)
      # Finds the constant K
      k = Math.log2(num_vertices).floor

      # Creates a new graph and add all the vertices
      graph = Graph.new
      num_vertices.times { graph.add_vertex(Graph::Vertex.create_random) }

      # Iterate over the vertices to connect everything
      graph.vertices.combination(2).each do |vertex_1, vertex_2|
        graph.create_edge(vertex_1, vertex_2, k)
      end

      # Consolidade all vertices edges into a single edge array in the graph
      # This is to make it easier to pass them to the view.
      graph.find_edges

      # Return the created graph
      graph
    end
  end

  # Class constructor. Parameters are optional
  def initialize(vertices = [], edges = [])
    @vertices = vertices
    @edges = edges
  end

  # Adds a new vertex to the graph, assigning an id to it corresponding to its
  # position in the array. This will break if a vertex is removed, but this is
  # not done here so I think it's safe.
  def add_vertex(vertex)
    vertex.id = vertices.size
    vertices << vertex
  end

  # Creates a new edge and adds it to the graph. 'from' and 'to' are vertices.
  # The edge is only added if the "to" vertex is sufficiently close to "from",
  # as only the max_edges nearest edges are allowed.
  def create_edge(from, to, max_edges)
    new_edge = Graph::Edge.new(from, to)
    if from.add_edge(new_edge, max_edges)
      unless to.add_edge(new_edge, max_edges)
        from.remove_edge(new_edge)
      end
    end
  end

  # Finds all edges from vertices and adds them all to the edges array
  def find_edges
    @edges = vertices.map(&:edges).flatten.uniq
  end

  # Transoforms the vertices into a string to be passed to the views
  def serialize_vertices
    vertices.map(&:to_s).join(',')
  end

  # Transoforms the edges into a string to be passed to the views
  def serialize_edges(target_edges = edges)
    target_edges.map(&:to_s).join(',')
  end

  # "to_string" method used to represent this object as a string
  def to_s
    "Graph (#{vertices.size} vertices, #{edges.size} edges) "
  end
end
