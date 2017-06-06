# place text characters into array of arrays with 2nd level arrays of n length, filled with spaces as needed
class Crypto

attr_accessor :text

  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    text.downcase.gsub(/\W/, "")
  end

  def plaintext_segments
    plain_segmentation(normalize_plaintext.chars, columns)
  end

  def size
    columns
  end

  def ciphertext
    ciphertext = ""
    (0..columns).each do |i|
      plaintext_segments.each do |seg|
        if seg.chars[i]
          ciphertext << seg.chars[i]
        next
        end
      end
    end
    ciphertext
  end

  def normalize_ciphertext
    if rows*columns == ciphertext.length
      cipher_segmentation(ciphertext.chars, rows)
    elsif ciphertext.length < 4
      cipher_segmentation(ciphertext.chars, rows+1)
    else
      normalize_array = ciphertext.chars
      fullsegments = normalize_array[0..((columns - empty_spaces)*rows - 1)]
      fullsegments = cipher_segmentation(fullsegments, rows)
      partialsegments = normalize_array[(columns - empty_spaces)*rows..-1]
      partialsegments = cipher_segmentation(partialsegments, rows-1)
      norm_cipher = fullsegments + " " + partialsegments
      norm_cipher
    end
  end

  private

  def columns #plaintext segment length
    Math.sqrt(normalize_plaintext.length).ceil
  end

  def rows #ciphertext segment length
    columns**2 == normalize_plaintext.length ? columns : columns - 1
  end

  def empty_spaces
    (columns*rows) - normalize_plaintext.length
  end

  def cipher_segmentation(text, length)
    text.each_slice(length).map(&:join).join(" ")
  end

  def plain_segmentation(text, length)
    text.each_slice(length).map(&:join)
  end
end
