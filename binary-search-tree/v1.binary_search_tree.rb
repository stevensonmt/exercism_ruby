class Bst

  # attr_reader :value
  attr_accessor :left, :right, :value

  def initialize(node)
    @value = node
    @left = EmptyNode.new
    @right = EmptyNode.new
  end

  def data
    data = []
    data << value
    data[0]
  end

  def insert(num)
    case value <=> num
      when 1 then insert_left(num)
      when -1 then insert_right(num)
      when 0 then insert_left(num) # the value is already present
    end
  end

  def inspect
    "{#{value}::#{left.inspect}|#{right.inspect}}"
  end


  def include?(num)
    case value <=> num
      when 1 then left.include?(num)
      when -1 then right.include?(num)
      when 0 then true # the current node is equal to the value
    end
  end

  private

  def insert_left(num)
    left.insert(num) or self.left = Bst.new(num)
  end

  def insert_right(num)
    right.insert(num) or self.right = Bst.new(num)
  end

end

class Bst::EmptyNode

  def include?(*)
    false
  end

  def insert(*)
    false
  end

  def inspect
    "{}"
  end
end
tree = Bst.new(10)
tree.left = Bst.new(5)
tree.right = Bst.new(15)
tree.insert(3)
tree.insert(10)
tree.insert(4)
tree.insert(6)
p tree
p tree.include?(10)
p tree.include?(8)
p tree.include?(3)
p tree.include?(15)
