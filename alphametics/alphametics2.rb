class Alphametics
  class << self
    def solve(input)
      @input = input
      @words = input_to_words
      @possible_values = {}
      @onesplace = []
      @tensplace = []
      @hundredsplace = []
      @thousandsplace = []
      @tenthousandsplace = []
      @hundredthousandsplace = []
      @millionsplace = []
      letters_to_keys
      words_to_columns
      guess

    end

    def input_to_words#takes the input string and returns array of individual "words", including summands and sum.
      @input.split(/\s/).delete_if {|x| x.match(/\W/) }
    end

    def letters_to_keys # populates possible_values hash with 0..9 per letter
      @words.join.chars.each {|char| @possible_values.store(char, (0..9).to_a)}
    end

    def words_to_columns#takes the array of words and returns array of letters grouped by column
      (0..@words[-1].length-1).each do |num|
        case
        when num == 0
          column = @onesplace
        when num == 1
          column = @tensplace
        when num == 2
          column = @hundredsplace
        when num == 3
          column = @thousandsplace
        when num == 4
          column = @tenthousandsplace
        when num == 5
          column = @hundredthousandsplace
        when num == 6
          column = @millionsplace
        when num > 6
          raise ArgumentError, 'ERROR too many digits to process'
        end
        columnize(column, num)
      end
    end

    def columnize(column, index)
      @words.each{|word| column << word.reverse[index]; column.compact! }
    end


    def guess
      n = 0
      guess_ones = @possible_values[@onesplace[n]]
      places = 0
      while n < @onesplace.length-2
        guess_ones = guess_ones.product(@possible_values[@onesplace[n+1]])
        n+=1
      end
      n = 0
      unless @tensplace.length < 2
        guess_tens = @possible_values[@tensplace[n]]
        while n < @tensplace.length-2
          unless @tensplace[n+1].nil?
            guess_tens = guess_tens.product(@possible_values[@tensplace[n+1]])
          end
          n+=1
        end
        places+=1
      end
      n = 0
      unless @hundredsplace.length < 2
        guess_hundreds = @possible_values[@hundredsplace[n]]
        while n < @hundredsplace.length-2
          unless @hundredsplace[n+1].nil?
            guess_hundreds = guess_hundreds.product(@possible_values[@hundredsplace[n+1]])
          end
          n+=1
        end
        places+=1
      end
      case
      when places == 0
        guesses = guess_ones

      when places == 1
        guesses = guess_ones.product(guess_tens)
      when places == 2
        guesses = guess_ones.product(guess_tens).product(guess_hundreds)

      end

      case @words[-1].length
      when 3
        possible_sum = @possible_values[@onesplace[-1]].product(@possible_values[@tensplace[-1]]).product(@possible_values[@hundredsplace[-1]])
      when 2
        possible_sum = @possible_values[@onesplace[-1]].product(@possible_values[@tensplace[-1]])
      when 1
        possible_sum = @possible_values[@onesplace[-1]]
      end
      sums = []
      possible_sum.each {|a| sum = 0 ; a.flatten.each_with_index {|b, ndx| sum +=  b*10**ndx }; sums << sum ; p sums}

    end
  end
end
Alphametics.solve("I + BB = ILL")
