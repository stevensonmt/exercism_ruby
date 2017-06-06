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
      exponents = (0..words[-1].length-1).to_a
      segments = generate_segments(words, exponents)
      candidates = letters_to_keys(letters)
      left_most_digit_of_sum_max(words, candidates)
      left_most_digit_is_not_0(first_letters(words), candidates)
      exp = 0
      while exp < exponents.length
        current_segments = segments[exp]
        current_letters = letters_to_chk(current_segments)
        guesses = guesses_per_exponent(current_letters, candidates)
        take_a_guess(guesses, candidates, segments, current_segments, current_letters, exp)
        exp+=1
      end


    end

    def words(input)
      input.split(/\s\W*/)
    end

    def letters(words)
      letters = []
      words.each{|word| letters << word.reverse.chars}
      letters
    end

    def letters_to_keys(letters) # create hash of letters and their possible values along with the exponent of the places they occupy in their numbers
      candidates = {}
      letters.each { |ary| ary.each {|ltr| candidates[ltr] = DIGITS } }
      candidates
    end

    def left_most_digit_of_sum_max(words, candidates) # the first digit of the sum has its value considerably constrained by the number summands when the sum has more digits than any of the individual summands
      if words[0..-2].all? {|word| word.length < words[-1].length}
        candidates[words[-1][0]] = (0..words.length-2).to_a
      end
    end

    def left_most_digit_is_not_0(letters, candidates) # the first digit of any number cannot be zero
      letters.each {|letter| candidates[letter] -= [0] }
    end

    def first_letters(words) # create an array of the first letter of each word -- for determining which letters cannot be zero
      a = []
      words.each { |word| a << word[0]}
      a.uniq
    end

    def int_sub_for_letter(segments_to_chk, letters_to_chk, ltr, guess) # substitute numbers for letters in string
      segments_to_chk.join("&&&").gsub!(ltr,guess[letters_to_chk.index(ltr)].to_s).split("&&&")
    end

    def guesses_per_exponent(current_letters, candidates)
      potential_values = get_potential_values(candidates, current_letters)
      guesses = generate_guesses(potential_values)
    end

    def get_potential_values(candidates, letters)
      potential_values = []
      letters.each do |ltr|
        potential_values << candidates[ltr]
      end
      potential_values
    end

    def generate_guesses(potential_values)
      guesses = potential_values[0].product(*potential_values[1..-1])
      guesses.reject!{|guess| guess.uniq.length != guess.length}
      guesses
    end

    def check_guess(guess, candidates, current_segments, current_letters, exp)
      nums_to_chk = current_segments
      current_letters.each do |ltr|
        nums_to_chk = int_sub_for_letter(nums_to_chk, current_letters, ltr, guess)
      end
      nums_to_chk.collect {|i| i.reverse.to_i}[0..-2].reduce(:+).to_s[-(exp+1)..-1] == nums_to_chk[-1].reverse
    end



    def generate_segments(words, exponents)
      segments_to_chk = {}
      exponents.each do |exp|
        segments_to_chk[exp] = words.collect {|word| word.reverse[0..exp]}
      end
      segments_to_chk
    end

    def letters_to_chk(segments, current_letters = [])
      segments.join.chars.uniq - current_letters
    end

    def take_a_guess(guesses, candidates, segments, current_segments, current_letters, exp)
      guesses.each do |guess|
        if check_guess(guess, candidates, current_segments, current_letters, exp)
          partial_solution = current_letters.zip(guess.each_slice(1).to_a).to_h
          p exp+=1
          next_segments = segments[exp]
          new_letters = letters_to_chk(next_segments) - current_letters
          new_letters.each{|ltr| partial_solution[ltr] = candidates[ltr]}
          next_letters = partial_solution.keys
          next_values = get_potential_values(partial_solution, next_letters)
          next_guesses = generate_guesses(next_values)
          take_a_guess(next_guesses, partial_solution, segments, next_segments, next_letters, exp)
        else
          p exp
        end
      end
    end

    def int_sub_for_letter(segments_to_chk, letters_to_chk, ltr, guess) # substitute numbers for letters in string
      segments_to_chk.join("&&&").gsub!(ltr,guess[letters_to_chk.index(ltr)].to_s).split("&&&")
    end

    def solution(guess, letters) # generate solution hash without mutating candidates hash
      letters.zip(guess).to_h
    end

  end
end
p Alphametics.solve("AS + A == MOM")
