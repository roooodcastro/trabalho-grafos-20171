# PriorityQueue implementation copied and adapted from
# https://gist.github.com/brianstorti/e20300eb2e7d62b87849
class PriorityQueue
  attr_reader :nodes

  # Class constructor
  def initialize
    @nodes = [nil]
  end

  # Inserts a new node to the tree, positioning it
  def insert(element, priority)
    @nodes << PriorityQueue::Node.new(element, priority)
    bubble_up(@nodes.size - 1)
    self
  end

  # Extracts the minimum priority node. It first saves the current priority,
  # sets it to positive infinity, moves it to the end, removes it and then
  # restores the original priority
  def extract_minimum
    min = nodes[1]
    min_priority = min.priority
    min.priority = Float::INFINITY
    bubble_down(1)
    nodes.delete(min)
    min.priority = min_priority
    min
  end

  # Decreases the priority of a node, correctly positioning it afterwards
  def decrease_priority(node, priority)
    node.priority = priority
    bubble_up(nodes.index(node))
  end

  private

  # Tries to move the element down in the tree (towards the leafs) to correctly
  # position it. This is needed after a decrease_priority or insert operation,
  # when we possibly can have an element with a low priority in the wrong place
  def bubble_up(index)
    parent_index = (index / 2)

    return if index <= 1
    return if @nodes[parent_index] <= @nodes[index]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  # Tries to move the element up in the tree (towards the root) to correctly
  # position it. This is needed after a extract_minimum operation, when we
  # increase the priority of the minimum element and need to position it at the
  # very end of the queue
  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @nodes.size - 1

    not_the_last_element = child_index < @nodes.size - 1
    left_element = @nodes[child_index]
    right_element = @nodes[child_index + 1]
    child_index += 1 if not_the_last_element && right_element < left_element

    return if @nodes[index] <= @nodes[child_index]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  def exchange(source, target)
    @nodes[source], @nodes[target] = @nodes[target], @nodes[source]
  end
end
