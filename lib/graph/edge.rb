# Represents a graph edge (or arc)
class Graph::Edge
  attr_reader :vertex_1, :vertex_2

  # Class constructor
  def initialize(vertex_1, vertex_2)
    @vertex_1 = vertex_1
    @vertex_2 = vertex_2
  end

  # Returns the edge length, which is equal to the distance between the vertices
  def length
    vertex_1.distance_to(vertex_2)
  end
end
