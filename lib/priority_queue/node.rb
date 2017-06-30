class PriorityQueue::Node
  include Comparable

  attr_accessor :priority
  attr_reader :element

  # Class constructor.
  def initialize(element, priority)
    @element = element
    @priority = priority
  end

  # Comparison method. Compares this node to another.
  def <=>(other)
    priority <=> other.priority
  end

  def inspect
    "Node (priority #{priority})"
  end
end
