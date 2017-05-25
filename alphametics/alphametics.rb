module BookKeeping
  VERSION = 4
end

class Alphametics
  class << self
    def solve(input)
      @input = input
      guess(@input)
    end

    def summands(input) #takes the input and separates summands from sum, removing the "+" character, returns array of "words" as strings
      input.split(" == ")[0].split(" + ")
    end

    def sum(input) # takes the input and separates sum from summands, returning a string of only letters
      input.split(" == ")[1]
    end

    def letters(input) # creates an array of unique letters from summands and sum
      (summands(input) + [sum(input)]).join.chars.uniq
    end

    def letters_to_keys(input)
      @candidates = {}
      letters(input).each {|ltr| @candidates[ltr] = (0..9).to_a}
      @candidates
    end

    def first_letters(input)
      a = []
      summands(input).each { |word| a << word[0]}
      a << sum(input)[0]
      a
    end

    def left_most_digit_is_not_0(letters, hash) # the first digit of any number cannot be zero
      letters.each {|ltr| hash[ltr] -= [0]}
    end

    def left_most_digit_of_sum_max(input, hash) # the first digit of the sum has its value considerably constrained by the number summands when the sum has more digits than any of the individual summands
      if summands(input).all? {|word| word.length < sum(input).length}
        hash[sum(input)[0]] = (0..summands(input).length-1).to_a
      end
    end

    def guess(input)
      letters_to_keys(@input)
      left_most_digit_of_sum_max(input, @candidates)
      left_most_digit_is_not_0(first_letters(input), @candidates)
      limit = @candidates.keys.length
      i = 1
      guesses = @candidates.values[0]
      while i < limit
        guesses = guesses.product(@candidates.values[i])
        i += 1
      end
      guesses.each do |guess|
        guess.flatten!
      end
      answer = {}
      guesses.each do |guess|
        if guess.uniq.length == guess.length && check_summation(guess)
          answer = solution(guess, @candidates)
        end
      end
      return answer
    end

    def check_summation(guess) # check that guess satisfies the sum
      nums = int_sub_for_letter(@input, @candidates, guess)
      summands(nums).collect!{|x| x.to_i}.reduce(:+) == sum(nums).to_i
    end

    def solution(guess, hash) # generate solution hash without mutating candidates hash
      hash.keys.zip(guess).to_h
    end

    def int_sub_for_letter(input, hash, guess)
      string = input
      (0..guess.length-1).each do |i|
        string = string.gsub(hash.keys[i], guess[i].to_s)

      end
      return string
    end


  end
end
# p Alphametics.solve("I + BB = ILL")
