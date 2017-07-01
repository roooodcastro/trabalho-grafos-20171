# Represents a graph vertex
class Graph::Vertex
  include Comparable

  attr_accessor :distance, :previous, :id
  attr_reader :x, :y, :edges

  # Static (class) methods
  class << self
    # Calculates the distance between 2 vertices.
    # x ** y denotes x to the power of y
    def distance(vertex_1, vertex_2)
      sum = ((vertex_1.x - vertex_2.x) ** 2) + ((vertex_1.y - vertex_2.y) ** 2)
      Math.sqrt(sum)
    end

    # Creates and returns a new vertex with random x and y positions,
    # in the [min, max] range
    def create_random(min = 0, max = 1.0)
      x = (min + (Random.rand * (max - min))).round(Graph::FLOAT_PRECISION)
      y = (min + (Random.rand * (max - min))).round(Graph::FLOAT_PRECISION)
      Graph::Vertex.new(x, y)
    end
  end

  # Class constructor
  def initialize(pos_x, pos_y)
    @x = pos_x
    @y = pos_y
    @edges = []
    @distance = Float::INFINITY
    @previous = nil
  end

  # Adds an edge as neighbour of this vertex
  def add_edge(edge)
    edges << edge
  end

  # Removes the specified edges from the neighbours
  def remove_edges(edges_to_remove)
    @edges = @edges - edges_to_remove
  end

  # Return this vertex's neighbours, as vertices
  def neighbours
    edges.map { |edge| edge.other_vertex(self) }
  end

  # Returns the N closest neighbours to this vertex, where N is amount. If N is
  # bigger than the total number of neighbours, all neighbours will be returned
  def closest_edges(amount)
    amount = [amount, neighbours.size].min
    edges[0..(amount - 1)]
  end

  # Returns all edges except the N closest neighbours to this vertex, where N
  # is amount. If N is bigger than the total number of neighbours, no
  # neighbours will be returned
  def farthest_edges(amount)
    amount = [amount, neighbours.size].min
    edges[amount..(edges.size - 1)]
  end

  # Calculates the distance between this vertex and another one
  def distance_to(another_vertex)
    Graph::Vertex.distance(self, another_vertex)
  end

  # Compares to vertices. Two vertices are the same if they occupy the same
  # point. In theory, there could be two different vertices that occupy the same
  # point, and therefore are wrongly assumed to be equal, but I'm hoping this
  # doesn't happen here...
  def <=>(other)
    return nil unless other.is_a? Graph::Vertex

    if distance != other.distance
      distance <=> other.distance
    else
      [x, y] <=> [other.x, other.y]
    end
  end

  def inspect
    to_s
  end

  # "to_string" method used to represent this object as a string
  # Format: id-x-y, example: '3-0.23478437-0.84736196'
  def to_s
    [x, y, previous&.id].join('-')
  end
end
