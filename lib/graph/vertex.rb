# Represents a graph vertex
class Graph::Vertex
  include Comparable

  attr_accessor :distance, :previous, :id, :next_vertices
  attr_reader :x, :y, :edges, :farthest_edge_distance

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
    @next_vertices = []
    @farthest_edge_distance = 0
  end

  # Adds an edge as neighbour of this vertex, but only if the number of edges
  # are below the limit or the new edge is sufficiently small.
  def add_edge(edge, max_edges)
    # Don't even bother if there are too many edges and this one is too big
    if edges.size >= max_edges && edge.length > farthest_edge_distance
      return false
    end

    edges << edge
    edges.sort! # Keep them sorted so we instantly know which is the farthest
    update_farthest_edge

    # Return if number of edges is below limit, no need to delete an edge
    return true if edges.size <= max_edges

    # Now we need to delete the farthest edge to keep the limit number of edges
    removed_edge = edges.pop
    removed_edge.other_vertex(self).remove_edge(removed_edge)
    update_farthest_edge
    true
  end

  # Removes an edge. This is used by add_edge, when an edge needs to be removed
  def remove_edge(edge)
    index_to_remove = edges.index(edge)
    return unless index_to_remove
    edges.delete_at(edges.index(edge))
    update_farthest_edge
  end

  # Updates the farthest edge distance
  def update_farthest_edge
    return @farthest_edge_distance = 0 if edges.empty?
    @farthest_edge_distance = edges.last.length
  end

  # Return this vertex's neighbours, as vertices
  def neighbours
    edges.map { |edge| edge.other_vertex(self) }
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

  # Compares to vertices. First try to compare their distances to the root, as
  # this is needed for Dijkstra, then, if they have the same distance, check if
  # they occupy the same position.
  def <=>(other)
    return nil unless other.is_a? Graph::Vertex

    if distance != other.distance
      distance <=> other.distance
    else
      [x, y] <=> [other.x, other.y]
    end
  end

  # Used to print this Object in debug console
  def inspect
    to_s
  end

  # "to_string" method used to represent this object as a string
  # Format: id-x-y, example: '3-0.23478437-0.84736196'
  def to_s
    next_vertices_string = next_vertices.map(&:id).compact.join('|')
    [x, y, next_vertices_string].join('-')
  end
end
