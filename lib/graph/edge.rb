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

  # Given a vertex belonging to this edge, this method returns the other vertex
  # that is included in the edge. If vertex is not in this edge, nil is returned
  def other_vertex(vertex)
    return nil unless vertex_1 == vertex || vertex_2 == vertex
    return vertex_1 if vertex == vertex_2
    vertex_2
  end

  # Comparison method. Compares this edge to another. Used to sort the edges
  def <=>(other)
    self.length <=> other.length
  end

  # "to_string" method used to represent this object as a string
  # Format: v1_id-v2_id, example: '3-42'
  def to_s
    "#{vertex_1.id}-#{vertex_2.id}"
  end
end
