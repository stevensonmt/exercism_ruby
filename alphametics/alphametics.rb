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
      candidates = letters_to_keys(letters)
      left_most_digit_of_sum_max(words, candidates)
      left_most_digit_is_not_0(first_letters(words), candidates)
      segments_to_chk = generate_segments(words, exponents)
      guessing(exponents, candidates, words, segments_to_chk, potential_values = [])
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

    def guessing(exponents, candidates, words, segments, potential_values = [])
      exp = 0
      while exp < exponents.length
        # current_segments = segments_to_chk[exp]
        # current_letters = letters_to_chk(current_segments)
        # p potential_values = get_potential_values(candidates, current_letters, potential_values)
        guesses = generate_guesses(candidates, words, segments, exp, potential_values)
        potential_values = []
        guesses.each do |guess|
          if check_each_guess(guess, segments, current_letters, exp)
            partial_solution = current_letters.zip(guess).to_h
            if partial_solution.keys == candidates.keys
              p "solution = #{partial_solution}"
              exp = exponents.length
              return partial_solution
              p exp
            else
              candidates.merge!(partial_solution)
              p candidates
              exp += 1
              p exp


            end
          end
        end
      end
    end

    def get_potential_values(candidates, current_letters, potential_values)
      current_letters.each do |ltr|
        potential_values << candidates[ltr]
      end
      potential_values
    end

    def generate_guesses(candidates, words, segments, exp, potential_values)
      current_letters = letters_to_chk(exp, segments)
      p potential_values = get_potential_values(candidates, current_letters, potential_values)
      case
      when potential_values[0].class == Array
      guesses = potential_values[0].product(*potential_values[1..-1])
        guesses.reject!{|guess| guess.uniq.length != guess.length}
      when potential_values[0].class == Integer
        guesses = [potential_values[0..-2]].product(potential_values[-1])
      end
      guesses
    end

    def check_each_guess(guess, current_segments, current_letters, current_exp)
      current_letters = letters_to_chk(exp, segments)
      nums_to_chk = current_segments
      current_letters.each do |ltr|
        nums_to_chk = int_sub_for_letter(nums_to_chk, current_letters, ltr, guess)
      end
      nums_to_chk.collect {|i| i.reverse.to_i}[0..-2].reduce(:+).to_s[-(current_exp+1)..-1] == nums_to_chk[-1].reverse
    end

    def generate_segments(words, exponents)
      segments_to_chk = {}
      exponents.each do |exp|
        segments_to_chk[exp] = words.collect {|word| word.reverse[0..exp]}
      end
      segments_to_chk
    end

    def letters_to_chk(exp, segments, current_letters = [])
      segments[exp].join.chars.uniq - current_letters
    end

    def update_candidates(letters_to_chk, guesses, candidates)
      letters_to_chk.each_with_index do |ltr, ndx|
        candidates[ltr] = guesses.collect{|guess| guess[ndx]}.uniq
      end
    end

    def take_a_guess(guesses, segments_to_chk, exponents, current_exp)
      guesses.each do |guess|
        letters_to_chk = letters_to_chk(segments_to_chk)
        letters_to_chk.each do |ltr|
          int_sub_for_letter(segments_to_chk, letters_to_chk, ltr, guess)
        end
        p segments_to_chk.collect {|i| i.reverse.to_i}[0..-2].reduce(:+).to_s[-(current_exp+1)..-1]
        p segments_to_chk[-1].reverse
        (current_exp..exponents[-1]).to_a.each do |new_exp|
          if segments_to_chk.collect {|i| i.reverse.to_i}[0..-2].reduce(:+).to_s[-(current_exp+1)..-1] == segments_to_chk[-1].reverse

            next new_exp
          else
            p "boo"
            next guess
          end
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
Alphametics.solve("AS + A == MOM")
