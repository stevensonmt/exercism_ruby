class FlattenArray
  VERSION = 1
  def self.flatten(input)
    while contains_arrays?(input)
      remove_arrays(input)
    end
    input -= [nil]
  end

  def self.contains_arrays?(input)
    input.any?{|i| i.class == Array}
  end

  def self.remove_arrays(input)
    input.each_with_index do |i, ndx|
      if i.class == Array
        i.each_with_index {|e, scndx| input.insert(scndx+ndx+1, e)}
        input.delete(i)
      end
    end
  end

end
