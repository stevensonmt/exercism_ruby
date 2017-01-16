class Bst
  VERSION = 1

  attr_reader :data, :left, :right
  def initialize(data)
    @data = data
    @nodes = 1
  end

  def insert(num)
    case data <=> num
      when 1 then insert_left(num)
      when -1 then insert_right(num)
      when 0 then insert_left(num) # the value is already present
    end

    @nodes += 1
  end

  def each(&block)
    return enum_for(:each) { @size } unless block_given?

    left && left.each(&block)
    yield data
    right && right.each(&block)
  end

  private

  def insert_left(value)
    if left
      left.insert(value)
    else
      @left = Bst.new(value)
    end
  end

  def insert_right(value)
    if right
      right.insert(value)
    else
      @right = Bst.new(value)
    end
  end
end
tree = Bst.new(10)
tree.insert(5)
tree.insert(15)
tree.insert(3)
# tree.insert(10)
# tree.insert(4)
# tree.insert(6)
p tree.left
# p tree.include?(10)
# p tree.include?(8)
# p tree.include?(3)
# p tree.include?(15)
