class PolyTreeNode
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "ERROR" unless @children.include?(child)
    child.parent = nil
  end

  def parent=(parent_node)
    @parent.children.delete(self) if @parent
    @parent = parent_node
    unless @parent.nil? || @parent.children.include?(self)
      parent_node.children << self
    end
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value.dup
  end

end
