module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end

class Array
  def accumulate
    each_with_object([]) do |element, acc|
      acc << yield(element)
    end
  end
end
