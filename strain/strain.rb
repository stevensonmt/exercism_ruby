class Array
  def keep &arg
    answer = []
    self.each {|i| answer << i if arg.call i}
    answer
  end

  def discard &arg
    answer = []
    self.each {|i| answer << i if !arg.call i }
    answer
  end
end
