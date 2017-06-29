# Represents a graph vertex
class Graph::Vertex
  attr_reader :x, :y

  # Static (class) methods
  class << self
    # Calculates the distance between 2 vertices.
    # x ** y denotes x to the power of y
    def distance(vertex_1, vertex_2)
      sum = ((vertex_1.x - vertex_2.x) ** 2) + ((vertex_1.y - vertex_2.y) ** 2)
      Math.sqrt(sum)
    end
  end

  # Class constructor
  def initialize(pos_x, pos_y)
    @x = pos_x
    @y = pos_y
  end

  # Calculates the distance between this vertex and another one
  def distance_to(another_vertex)
    Graph::Vertex.distance(self, another_vertex)
  end
end
