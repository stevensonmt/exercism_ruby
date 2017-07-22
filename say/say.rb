class Say

  DIGIT_TRANSLATION_TABLE =
    {
      0 => {
        "0" => "zero",
        "1" => "one",
        "2" => "two",
        "3" => "three",
        "4" => "four",
        "5" => "five",
        "6" => "six",
        "7" => "seven",
        "8" => "eight",
        "9" => "nine"
      },
      1 => {
        "0" => "",
        "1" => {
          "0" => "ten",
          "1" => "eleven",
          "2" => "twelve",
          "3" => "thirteen",
          "4" => "fourteen",
          "5" => "fifteen",
          "6" => "sixteen",
          "7" => "seventeen",
          "8" => "eighteen",
          "9" => "nineteen",
        },
        "2" => "twenty-",
        "3" => "thirty-",
        "4" => "forty-",
        "5" => "fifty-",
        "6" => "sixty-",
        "7" => "seventy-",
        "8" => "eighty-",
        "9" => "ninety-",
      },
      2 => " hundred "
    }

  SEGMENT_TRANSLATION_TABLE =
    {
      0 => "",
      1 => " thousand ",
      2 => " million ",
      3 => " billion "
    }

  def initialize(num)
    if num < 0 || num >= 10**12
      raise ArgumentError
    else
      @num = num
    end
  end

  def in_english
    @english = ""
    num_to_segments_of_3_digits.each_with_index do |segment, ndx|
      @english.prepend(translate_segment(segment, ndx))
    end
    @english.sub!(/-*\s*$/, "")
  end

  private

  def num_to_segments_of_3_digits
    @num.to_s.reverse.chars.each_slice(3)
  end

  def translate_segment(segment, segndx)
    numstr = ""
    numstr = hundreds_place(segment, numstr) unless segment[2].nil? || segment[2] == "0"
    unless segment[1].nil?
      tens_place(segment, numstr)
    else
      ones_place(segment, numstr)
    end
    digit_group_title(numstr, segment, segndx)
  end

  def hundreds_place(segment, numstr)
    numstr << DIGIT_TRANSLATION_TABLE[0][segment[2]] + DIGIT_TRANSLATION_TABLE[2]
  end

  def tens_place(segment, numstr)
    if segment[1] == "1"
      numstr << DIGIT_TRANSLATION_TABLE[1][segment[1]][segment[0]]
    else
      numstr << DIGIT_TRANSLATION_TABLE[1][segment[1]]
      if segment[0] == "0"
        numstr.rstrip!
      else
        ones_place(segment, numstr)
      end
    end
  end

  def ones_place(segment, numstr)
    numstr << DIGIT_TRANSLATION_TABLE[0][segment[0]]
  end

  def digit_group_title(numstr, segment, segndx)
    numstr << SEGMENT_TRANSLATION_TABLE[segndx] unless segment.all? {|i| i == "0"}
    numstr
  end

end

module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end
