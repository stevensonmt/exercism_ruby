module BookKeeping
  VERSION = 4
end
# Currently generates hash of letters with possible values and the exponents for the places in which those letters appear.  should be more efficient to solve exponent by exponent, I would think.
class Alphametics
  class << self
    DIGITS = (0..9).to_a

    def solve(input)
      @input = input
      words = words(input)
      letters = letters(words)
      exponents = exponents(letters)
      p exponents.length
      candidates = letters_to_keys(letters)
      p candidates
      left_most_digit_of_sum_max(words, candidates)
      left_most_digit_is_not_0(first_letters(words), candidates)
      p candidates
      exponents.each_key do |current_exp|
        guesses = generate_guesses(candidates, exponents, current_exp)
        p guesses
        guess(guesses, current_exp)
      end

      # guess(words)
    end

    def words(input)
      input.split(/\s\W*/)
    end

    def summands(words) #takes the input and separates summands from sum, removing the "+" character, returns array of "words" as strings
      words[0..-2]
    end

    def sum(words) # takes the input and separates sum from summands, returning a string of only letters
      words[-1]
    end

    def letters(words)
      letters = []
      words.each{|word| letters << word.reverse.chars}
      letters
    end

    def exponents(letters) # create a hash of numeral places and the letters in those places
      exponents  = {}
      letters.each_index do |ndx|
        exponents[ndx] = []
        letters.each do |ltr|
          exponents[ndx] << ltr[ndx]
          exponents[ndx] = exponents[ndx].compact
        end
      end
      exponents
    end

    def letters_to_keys(letters) # create hash of letters and their possible values along with the exponent of the places they occupy in their numbers
      candidates = {}
      letters.each { |ary| ary.each {|ltr| candidates[ltr] = DIGITS } }
      candidates
    end

    def guess(guesses, exp)
      guesses.each do |guess|
        p "++++++"
        p guesses.length
        reject_guess?(guesses, guess, @letters_to_chk, exp)
        p "======"
        p guesses.length
      end
        p @candidates
      # end
    end

    def left_most_digit_of_sum_max(words, candidates) # the first digit of the sum has its value considerably constrained by the number summands when the sum has more digits than any of the individual summands
      if words[0..-2].all? {|word| word.length < words[-1].length}
        candidates[words[-1][0]] = (0..words.length-2).to_a
      end
    end

    def left_most_digit_is_not_0(letters, candidates) # the first digit of any number cannot be zero
      letters.each {|letter| p letter ; p candidates[letter] ; candidates[letter] -= [0] ; p candidates[letter]}
    end

    def first_letters(words) # create an array of the first letter of each word -- for determining which letters cannot be zero
      a = []
      words.each { |word| a << word[0]}
      p a.uniq
    end

    def generate_guesses(candidates, exponents, current_exp)
      potential_values = []
      @letters_to_chk = exponents[current_exp]
      @letters_to_chk.each do |ltr|
        potential_values << candidates[ltr]
      end
      guesses = potential_values[0].product(*potential_values[1..-1])
      return guesses
    end

    def check_summation(letters, guess, exp) # check that guess satisfies the summation
      nums = int_sub_for_letter(@input, letters, guess)
      nums #= nums.split(/\d*[A-Z]|\b\D*/).delete_if{|i| i==""}.collect {|i| i = i.to_i}
      # nums[0..-2].reduce(:+).to_s[-1].to_i == nums[-1]
      # summands(words(nums)).collect{|x| x.to_i}.reduce(:+) == sum(words(nums))[-1].to_i
    end

    def check_guess(guess, exp)
      p guess[0..-2].reduce(:+) == (guess[-1] || guess[-1]+10**(exp+1))
    end

    def reject_guess?(guesses, guess, letters, exp)
      unless check_summation(letters, guess, exp)
        p "//////////////////////////"
        p guess
        p guesses.index(guess)
        p guesses
        guesses -= [guess]
        p guesses.length
      end
      # update_candidates(letters, guesses)
    end

  def update_candidates(letters, guesses)
    p guesses
    p letters
    letters.each_with_index do |ltr, ndx|
      h = { ltr => [] }
    #   p @candidates[ltr]
    #   @candidates[ltr] = []
    #   p @candidates[ltr]
      guesses.each do |guess|
        p guess
        unless h[ltr].include?(guess[ndx])
          h[ltr] += [guess[ndx]]
        end
        @candidates.merge!(h)
        p @candidates
      end
    end
  end

    def int_sub_for_letter(input, letters, guess) # substitute numbers for letters in string
      string = input
      (0..guess.length-1).each do |i|
        string = string.gsub(letters[i], guess[i].to_s)
      end
      p string
    end

    def solution(guess, letters) # generate solution hash without mutating candidates hash
      letters.zip(guess).to_h
    end


  end
end
Alphametics.solve("AS + A == MOM")
