module BookKeeping
  VERSION = 3 # Where the version number matches the one in the test.
end

class School
  def initialize
    @school = Hash.new { [] }
  end

  def add(student, level)
    @school[level] <<= student
    @school[level].sort!
  end

  def students(x)
      @school[x]
  end

  def students_by_grade
    @school.map { |grade, name| { grade: grade, students: name } }.sort_by {|i| i[:grade]}
  end


end
