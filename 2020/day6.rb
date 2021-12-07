testfile = File.open('input/day6-test.txt')
file = File.open('input/day6.txt')

class Day6
  def initialize(f)
    @data = f.readlines.map do |line|
      # maybe do other stuff too 
      line.chomp
      #chomp chomp chomp
    end
  end

  def part_one
  end

  def part_two
  end  
end

Day6.new(testfile).part_one
# Day6.new(file).part_one
# Day6.new(testfile).part_two
# Day6.new(file).part_two
