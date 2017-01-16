class PhoneNumber
  DefaultNumber = '0000000000'

  def initialize phonenumber
    @phonenumber = phonenumber
  end

  def clean(n)
    if no_alpha(n)
      only_digits(n)
      length11or10?(n)
    else
      n = DefaultNumber
    end
  end

  def number
    number = clean(@phonenumber)
  end

  def area_code
    number[0..2]
  end

  def no_alpha(n)
    n.split('').select {|i| i =~ /[a-z]/}.empty?
  end

  def only_digits(n)
    n.gsub!(/\D*/, '')
  end

  def length11or10?(n)
    if n.length == 11 && n[0] == "1"
      n = n[1..-1]
    elsif n.length == 10
      n
    else
      number = DefaultNumber
    end
  end

  def to_s
    if no_alpha(number)
      length11or10?(number)
      "(" + area_code + ") " + number[3..5] + "-" + number[6..9]
    end
  end
end
