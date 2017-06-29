# Represents a graph vertex
class Graph::Vertex
  attr_reader :x, :y, :id

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
  end

  # Calculates the distance between this vertex and another one
  def distance_to(another_vertex)
    Graph::Vertex.distance(self, another_vertex)
  end

  # Sets the id for this vertex. The id is assigned by the graph to identify a
  # vertex and is used by the edge to know which vertices they connect. This is
  # done to save bandwidth when we need to generate the HTML page with all edge
  # information.
  def set_id(id)
    @id = id
  end

  # "to_string" method used to represent this object as a string
  # Format: id-x-y, example: '3-0.23478437-0.84736196'
  def to_s
    [id, x, y].join('-')
  end
end
