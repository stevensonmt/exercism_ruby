class Say
# Make methods for translating tens separate from everything else.
# Divide num into groups according to exponent (0..2)(3..5)(6..8)(9..11)
#Translate each group first, then join.  Tens are joined by "-"
# but all other places joined by ""
  TRANSLATE_BY_EXPONENTS = {
    0 => {
      0 => "zero",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine"
      },
    1 => {
      1 => {
        0 => "ten",
        1 => "eleven",
        2 => "twelve",
        3 => "thirteen",
        4 => "fourteen",
        5 => "fifteen",
        6 => "sixteen",
        7 => "seventeen",
        8 => "eighteen",
        9 => "nineteen"
        },
      2 => "twenty",
      3 => "thirty",
      4 => "forty",
      5 => "fifty",
      6 => "sixty",
      7 => "seventy",
      8 => "eighty",
      9 => "ninety"
      },
    }

  GROUPINGS = { 0 => "hundred", 1 => "thousand", 2 => "million", 3 => "billions"}

  def initialize(num)
    @num = num
  end

  def in_english
    p num_to_expanded_notation

    # if h.keys.length > 1
    #   if h[1] == 1
    #     p TRANSLATE_BY_EXPONENTS[1][1][h[0]]
    #   elsif h[0] == 0
    #     p TRANSLATE_BY_EXPONENTS[1][h[1]]
    #   else
    #     p h.map{|k,v| TRANSLATE_BY_EXPONENTS[k][v]}.reverse.join("-")
    #   end
    # else
    #   p h.map{|k,v| TRANSLATE_BY_EXPONENTS[k][v]}.join
    # end

  end

  private

  def num_to_expanded_notation
    @num.to_s.reverse.chars.each_with_index.chunk_while{|numndx|(numndx[1]+1) % 3 == 0}.to_a.each_with_index.with_object({}){ |arrndx, hsh| hsh[arrndx[1]] = arrndx[0] }
    # with_object({}){|(i, ndx), h| h[ndx] = i.to_i}
  end

  def divide_into_powers_of_three
    p num_to_expanded_notation.chunk_while{|kv| (kv[0]+1) % 3 != 0}.to_a.each_with_index.with_object({}){ |arrndx, hsh| hsh[arrndx[1]] = arrndx[0] }#.map{|k,v| [GROUPINGS[k], v]}]
  end

  def translate_each_group
    english_num = ""
    divide_into_powers_of_three.each do |k, arr_of_arr|
      p "#{k} is k and #{arr_of_arr} is current arr"
      arr_of_arr.reverse!.each_with_index do |arr, ndx|
        p arr ; p ndx
        if arr[0] == 2
          english_num << TRANSLATE_BY_EXPONENTS[0][arr[1]] + " "
          english_num << GROUPINGS[k] + " "
        elsif arr == [1,1]
          english_num << TRANSLATE_BY_EXPONENTS[arr[0]][arr[1]][arr_of_arr[ndx+1][1]]
          return english_num
        else
          english_num << TRANSLATE_BY_EXPONENTS[arr[0]][arr[1]] + "-"
        end
      end
      english_num << GROUPINGS[k]
    end
    p english_num
  end
p TRANSLATE_BY_EXPONENTS[3]
end

p Say.new(3114).in_english
