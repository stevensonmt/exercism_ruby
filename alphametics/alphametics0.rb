class Alphametics
  def nil
    nil.to_i
  end
  def self.solve(input)
    @words = input.split(/\s/).delete_if {|x| x.match(/\W/) }
    @max_length = @words[-1].length
    @paddedwords = []
    @words.each { |word| @paddedwords << word.rjust(@max_length, " ") }
    @solution = {}#{" " => [0]}
    @words.join.split('').each { |letter|
      @solution.store(letter, (0..9).to_a)
    }
    (0..@max_length-1).each { |i| all_in_column_same?(i) }
    is_sum_left_digit_1?
    @words.each {|word| left_most_digit_is_not_0(word) }
    each_column_adds_up
    @solution.each { |k,v| @solution.store(k, v.join('')) }
    @solution

  end

  #Check if all letters of same index the same and if so assign value based on number of summands
  def self.all_in_column_same?(column)
    @current_letter = @paddedwords[-1][column]
    if @paddedwords.all? { |word| word[column] == @current_letter }
      case
        when @words.length - 1 == 2
          @solution.store(@current_letter, [0])
          prune_possible_solns(@current_letter, [0])
        when (@words.length - 1).odd?
          @solution.store(@current_letter, [0, 5])
        when @words.length - 1 == 4
          @solution.store(@current_letter, [0, 6])
        when @words.length - 1 == 6
          @solution.store(@current_letter, [0, 2, 4, 6, 8])
        when @words.length - 1 == 8
          @solution.store(@current_letter, [0])
          prune_possible_solns(@current_letter, [0])
      end
    end
  end


    #If number of summands == 2 and sum has more digits than any summand, then the left-most digit of sum == -1
    def self.is_sum_left_digit_1?
      if (0..@words.length - 2).all? {|i| @words[i].length < @words[-1].length }
        @solution.store(@words[-1][0], [1])
      end
      prune_possible_solns(@words[-1][0], [1])
    end

    def self.left_most_digit_is_not_0(word)
      @solution.store(word[0], @solution[word[0]] - [0])
    end

    def self.prune_possible_solns(letter, num)
      @solution.keys.reject{|k| k == letter}.each { |k| @solution.store(k, @solution[k] - num) }
    end

def self.each_column_adds_up
  rows = []
  (0..@paddedwords.length-1).each { |i| rows << @paddedwords[i].chars }
  columns = rows.transpose.reverse
  columns.each_with_index do |i, ndx|
    p i.to_s + "+++++++________+++++++++" + ndx.to_s
    n = 1
    if ndx == 0
      while n <= i.length-2
        if @solution[i[0]] && @solution[i[n]]
          candidates = @solution[i[0]].product(@solution[i[n]])
        elsif @solution[i[0]].nil? && @solution[i[n]].nil?
          p "[][][][][][][][][][][][][][][]"
          candidates = []
        elsif @solution[i[n]].nil?
          candidates = @solution[i[0]].product([0])
        elsif @solution[i[0]].nil?
          p i[n]
          p i[-1]
          candidates = [0].product(@solution[i[n]])
        end
      p candidates
      p "+++++++++++++++++++"
      n += 1
      end
    candidates.each do |combo|
      p combo
      unless @solution[i[-1]].include? (combo.reduce(:+) || combo.reduce(:+) - 10) #.to_s[-1].to_i
        candidates -= combo
      end
    end


    end
    p candidates
    p "|||||||||||||||||||||"
    candidates.transpose.each {|z| z.uniq!}.each_with_index {|x, ndx| @solution[i[ndx]] = x }
    p "{{{{{{{{{{{{{{{{{{}}}}}}}}}}}}}}}}}}"
    p @solution
  end
end


def self.letter_solved?(letter)
  @solution[letter].length == 1
end



end
p Alphametics.solve("I + BB = ILL")
