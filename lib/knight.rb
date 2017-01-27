require_relative "00_tree_node"

class KnightPathFinder
  DELTAS = [
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1]
  ]

  def self.valid_moves(pos)
    x, y = pos
    result = DELTAS.map { |dx, dy| [x + dx, y + dy] }
    result.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @move_tree = build_move_tree
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]

    until queue.empty?
      parent = queue.shift
      children = new_move_positions(parent.value)
      children.map! { |new_pos| PolyTreeNode.new(new_pos) }
      children.each { |child| parent.add_child(child) }
      queue += children
    end
    root
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos)
    new_moves.reject! { |move| @visited_positions.include?(move) }
    @visited_positions.concat(new_moves)
    new_moves
  end

  def find_path(end_pos)
    final_dest = @move_tree.dfs(end_pos)
    trace_path_back(final_dest)
  end

  def trace_path_back(node)
    return [node.value] if node.parent.nil?
    trace_path_back(node.parent) + [node.value]
  end

end
