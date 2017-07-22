class Queens
  def initialize(**args)
    unless args.values.all? {|a| a.all? {|i| (0..7).cover?(i) }}
      raise ArgumentError
    end
    @white = args[:white]
    @black = args[:black]
  end

  def attack?
    @white[0] == @black[0] ||
    @white[1] == @black[1] ||
    (@white[0] - @black[0]).abs == (@white[1] - @black[1]).abs
  end
end

module BookKeeping
  VERSION = 2
end
