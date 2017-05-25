module BookKeeping
  VERSION = 4
end

class Alphametics
  class << self
    def solve(input)
      @input = input
      @words = input_to_words(@input)
      @possible_values = {}
      letters_to_keys
      left_most_digit_is_not_0(@words)
      left_most_digit_of_sum_max(@words)
      @solution = {}
      guess(@possible_values.keys.length)
      @solution

    end

    def input_to_words(input)#takes the input string and returns array of individual "words", including summands and sum.
      input.split(/\s/).delete_if {|x| x.match(/\W/) }

    end

    def letters_to_keys # populates possible_values hash with 0..9 per letter
      @words.join.chars.each {|char| @possible_values.store(char, (0..9).to_a)}
    end

    def left_most_digit_is_not_0(words)
      words.each{|word|@possible_values.store(word[0], @possible_values[word[0]] - [0])}
    end

    def left_most_digit_of_sum_max(words)
      if words[0..-2].all?{|word| word.length < words[-1].length }
        @possible_values[words[-1][0]] = (1..words.length-2).to_a
      end
    end

    def guess(num_of_ltrs)
      if num_of_ltrs == 10
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            (@possible_values[@possible_values.keys[1]]-[a]).each do |b|
              (@possible_values[@possible_values.keys[2]]-[a,b]).each do |c|
                (@possible_values[@possible_values.keys[3]]-[a,b,c]).each do |d|
                  (@possible_values[@possible_values.keys[4]]-[a,b,c,d]).each do |e|
                    (@possible_values[@possible_values.keys[5]]-[a,b,c,d,e]).each do |f|
                      (@possible_values[@possible_values.keys[6]]-[a,b,c,d,e,f]).each do |g|
                        (@possible_values[@possible_values.keys[7]]-[a,b,c,d,e,f,g]).each do |h|
                          (@possible_values[@possible_values.keys[7]]-[a,b,c,d,e,f,g,h]).each do |i|
                            (@possible_values[@possible_values.keys[7]]-[a,b,c,d,e,f,g,h,i]).each do |j|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          guess = letter_sub_for_value(guess, e, 4)
                          guess = letter_sub_for_value(guess, f, 5)
                          guess = letter_sub_for_value(guess, g, 6)
                          guess = letter_sub_for_value(guess, h, 7)
                          guess = letter_sub_for_value(guess, i, 8)
                          guess = letter_sub_for_value(guess, j, 9)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c,d,e,f,g,h,i,j].length == [a,b,c,d,e,f,g,h,i,j].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                            @solution.store(@possible_values.keys[4], e)
                            @solution.store(@possible_values.keys[5], f)
                            @solution.store(@possible_values.keys[6], g)
                            @solution.store(@possible_values.keys[7], h)
                            @solution.store(@possible_values.keys[8], i)
                            @solution.store(@possible_values.keys[9], j)
                          end
                        end
                      end
                    end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      if num_of_ltrs == 8
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            (@possible_values[@possible_values.keys[1]]-[a]).each do |b|
              (@possible_values[@possible_values.keys[2]]-[a,b]).each do |c|
                (@possible_values[@possible_values.keys[3]]-[a,b,c]).each do |d|
                  (@possible_values[@possible_values.keys[4]]-[a,b,c,d]).each do |e|
                    (@possible_values[@possible_values.keys[5]]-[a,b,c,d,e]).each do |f|
                      (@possible_values[@possible_values.keys[6]]-[a,b,c,d,e,f]).each do |g|
                        (@possible_values[@possible_values.keys[7]]-[a,b,c,d,e,f,g]).each do |h|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          guess = letter_sub_for_value(guess, e, 4)
                          guess = letter_sub_for_value(guess, f, 5)
                          guess = letter_sub_for_value(guess, g, 6)
                          guess = letter_sub_for_value(guess, h, 7)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c,d,e,f,g,h].length == [a,b,c,d,e,f,g,h].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                            @solution.store(@possible_values.keys[4], e)
                            @solution.store(@possible_values.keys[5], f)
                            @solution.store(@possible_values.keys[6], g)
                            @solution.store(@possible_values.keys[7], h)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      elsif num_of_ltrs == 7
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            (@possible_values[@possible_values.keys[1]]-[a]).each do |b|
              (@possible_values[@possible_values.keys[2]]-[a,b]).each do |c|
                (@possible_values[@possible_values.keys[3]]-[a,b,c]).each do |d|
                  (@possible_values[@possible_values.keys[4]]-[a,b,c,d]).each do |e|
                    (@possible_values[@possible_values.keys[5]]-[a,b,c,d,e]).each do |f|
                      (@possible_values[@possible_values.keys[6]]-[a,b,c,d,e,f]).each do |g|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          guess = letter_sub_for_value(guess, e, 4)
                          guess = letter_sub_for_value(guess, f, 5)
                          guess = letter_sub_for_value(guess, g, 6)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c,d,e,f,g].length == [a,b,c,d,e,f,g].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                            @solution.store(@possible_values.keys[4], e)
                            @solution.store(@possible_values.keys[5], f)
                            @solution.store(@possible_values.keys[6], g)
                          end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      elsif num_of_ltrs == 6
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            (@possible_values[@possible_values.keys[1]]-[a]).each do |b|
              (@possible_values[@possible_values.keys[2]]-[a,b]).each do |c|
                (@possible_values[@possible_values.keys[3]]-[a,b,c]).each do |d|
                  (@possible_values[@possible_values.keys[4]]-[a,b,c,d]).each do |e|
                    (@possible_values[@possible_values.keys[5]]-[a,b,c,d,e]).each do |f|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          guess = letter_sub_for_value(guess, e, 4)
                          guess = letter_sub_for_value(guess, f, 5)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c,d,e,f].length == [a,b,c,d,e,f].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                            @solution.store(@possible_values.keys[4], e)
                            @solution.store(@possible_values.keys[5], f)
                          end
                      end
                    end
                  end
                end
              end
            end
          end
      elsif num_of_ltrs == 5
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            @possible_values[@possible_values.keys[1]].each do |b|
              @possible_values[@possible_values.keys[2]].each do |c|
                @possible_values[@possible_values.keys[3]].each do |d|
                  @possible_values[@possible_values.keys[4]].each do |e|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          guess = letter_sub_for_value(guess, e, 4)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c,d,e].length == [a,b,c,d,e].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                            @solution.store(@possible_values.keys[4], e)
                          end
                      end
                    end
                  end
                end
              end
            end
      elsif num_of_ltrs == 4
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            @possible_values[@possible_values.keys[1]].each do |b|
              @possible_values[@possible_values.keys[2]].each do |c|
                @possible_values[@possible_values.keys[3]].each do |d|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          guess = letter_sub_for_value(guess, d, 3)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a..d].length == [a..d].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                            @solution.store(@possible_values.keys[3], d)
                          end
                      end
                    end
                  end
                end
              end
      elsif num_of_ltrs == 3
        if @possible_values.keys.length > 1 && @words.length > 2
          @possible_values[@possible_values.keys[0]].each do |a|
            (@possible_values[@possible_values.keys[1]]-[a]).each do |b|
              (@possible_values[@possible_values.keys[2]]-[b]).each do |c|
                          guess = @input
                          guess = letter_sub_for_value(guess, a, 0)
                          guess = letter_sub_for_value(guess, b, 1)
                          guess = letter_sub_for_value(guess, c, 2)
                          individual_numbers = input_to_words(guess)
                          individual_numbers.collect!{|num| num.to_i}
                          if individual_numbers[0..-2].reduce(:+) == individual_numbers[-1] && [a,b,c].length == [a,b,c].uniq.length
                            @solution.store(@possible_values.keys[0], a)
                            @solution.store(@possible_values.keys[1], b)
                            @solution.store(@possible_values.keys[2], c)
                          end
                      end
                    end
                  end
                end
      end
    end

    def letter_sub_for_value(string, value, key_ndx)
      string.gsub(@possible_values.keys[key_ndx], value.to_s)
    end


  end
end
# p Alphametics.solve("I + BB = ILL")
