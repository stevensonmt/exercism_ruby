class Bst
  VERSION = 1

  class EmptyNode
    def initialize(num)
      @data = num
      @left = EmptyNode.new
      @right = EmptyNode.new
    end

    def insert(*)
      false
    end

  end

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
    else raise "something went wrong during insertion"
    end

    @nodes += 1
  end

  def each(&block)
    return enum_for(:each) { @nodes } unless block_given?
    left && left.each(&block)
    yield data
    right && right.each(&block)

    self
  end

  private

  def insert_left(value)
    left && left.insert(value) || @left = Bst.new(value)
  end

  def insert_right(value)
    right && right.insert(value) || @right = Bst.new(value)
  end

end
