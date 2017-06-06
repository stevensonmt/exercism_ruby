class RailFenceCipher
  def self.encode(str, rows)
    if invalid_str?(str, rows)
      return str
    else
      letters = strip_letters(str)
      map = generate_map(letters, rows)
      map_letters_to_rows_collapse_rows(letters, map)
    end
  end

  def self.decode(str, rows)
    if invalid_str?(str, rows)
      return str
    else
      map = generate_map(str, rows)
      arr = map_codedstr_to_rows(str, map)
      map_coded_rows_to_decoded_str(arr, str, rows)
    end
  end

  def self.strip_letters(str)
    str.gsub(/\W/, '')
  end

  def self.generate_map(str, rows)
    h = generate_rows(str, rows)
    rails_pattern(rows).cycle((str.length.to_f/rails_pattern(rows).length.to_f).ceil).with_index do |i, ndx|
      h[i] << ndx unless ndx > str.length
    end
    h
  end

  def self.generate_rows(str, rows)
    (1..rows).to_a.each_with_object({}){|i, o| o[i] = []}
  end

  def self.map_letters_to_rows_collapse_rows(letters, map)
    map.values.flatten.collect{ |i| letters[i] }.compact.join
  end

  def self.map_codedstr_to_rows(str, map)
    position = 0
    map.values.each_with_object([]){|v, arr| arr << str[position..(position + v.length-1)] ; position += v.length ; arr}.map{ |str| str.chars }
  end

  def self.map_coded_rows_to_decoded_str(row_array, str, rows)
    rails_pattern(rows).cycle((str.length.to_f/rails_pattern(rows).length.to_f).ceil).with_object([]){|i, o| o << row_array[i-1].shift }.join
  end


  def self.invalid_str?(str, rows)
    str.chars.empty? || rows > str.length || rows == 1
  end

  def self.rails_pattern(rows)
    ((1..rows).to_a + (2..rows-1).to_a.reverse)
  end

VERSION = 1
end
