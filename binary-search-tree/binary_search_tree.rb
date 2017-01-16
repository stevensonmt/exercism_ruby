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
    return enum_for(:each) { @nodes } unless block_given?
    left && left.each(&block)
    yield data
    right && right.each(&block)

    self
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
