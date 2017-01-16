module BookKeeping
  VERSION = 2 # Where the version number matches the one in the test.
end
class Fixnum
ROM_NUM_MAP = { 1000 => "M", 900 => "CM", 500 => "D", 400 => "CD", 100 => "C",
  90 => "XC", 50 => "L", 40 => "XL", 10 => "X", 9 => "IX", 5 => "V", 4 => "IV", 1 => "I" }

  def to_roman
    num = self
    rom_num = ""
    while num > 0 do
      number, romandigit = ROM_NUM_MAP.find { |number, romandigit| num >= number }
      num -= number
      rom_num << romandigit
    end
    rom_num
  end
end
