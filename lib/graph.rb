# A graph implementation
class Graph
  attr_reader :vertices, :edges

  # Limits the floating point precision to 8 decimal places
  FLOAT_PRECISION = 8

  # Static (class) methods
  class << self
    # Created and returns a new graph consisting of {nmum_vertices} vertices.
    # All of the vertices will be connected to each other, as specified in the
    # problem description.
    def create_random_graph(num_vertices)
      graph = Graph.new
      # Create and add all the vertices
      num_vertices.times { graph.add_vertex(Graph::Vertex.create_random) }
      # Iterate over the vertices to connect everything
      graph.vertices.each do |vertex_1|
        graph.vertices.each { |vertex_2| graph.create_edge(vertex_1, vertex_2) }
      end
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
    vertex.set_id(vertices.size)
    vertices << vertex
  end

  # Creates a new vertex based on positions x and y and adds it to the graph
  def create_vertex(x, y)
    vertices << Graph::Vertex.new(x, y)
  end

  # Creates a new edge and adds it to the graph. 'from' and 'to' are vertices
  def create_edge(from, to)
    edges << Graph::Edge.new(from, to)
  end

  # "to_string" method used to represent this object as a string
  def to_s
    "Graph (#{vertices.size} vertices, #{edges.size} edges) "
  end
end
