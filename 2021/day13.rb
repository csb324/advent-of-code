require 'pry-byebug'
testfile = File.open('input/day13-test.txt')
file = File.open('input/day13.txt')

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def apply_fold(fold)
    if fold[:direction] == "x"
      if fold[:position] < @x
        distance_from_fold = @x - fold[:position]
        @x = fold[:position] - distance_from_fold
      end
    else
      if fold[:position] < @y
        distance_from_fold = @y - fold[:position]
        @y = fold[:position] - distance_from_fold
      end
    end

    self
  end

  def id 
    return "#{@x}, #{@y}"
  end

end

class Day13
  def initialize(f)
    @points = []
    @folds = []
    f.readlines.map do |line|
      # maybe do other stuff too 
      line.chomp!

      if(line.split(",")[1])
        @points.push(Point.new(line.split(",")[0], line.split(",")[1]))
      end

      if line =~ /fold along/
        @folds.push({
          direction: line.split("=")[0].split("").last,
          position: line.split("=")[1].to_i
        })
      end
    end
  end

  def part_one

    visible_points = []
    only_fold = @folds.first

    @points.each do |point|
      visible_points.push(point.apply_fold(only_fold).id)
    end
    # binding.pry
    puts visible_points.uniq.length
  end

  def part_two

    @folds.each do |fold|      
      @points.each do |point|
        point.apply_fold(fold)
      end
    end

    display = []
    
    @points.each do |point|
      unless (display[point.y])
        display[point.y] = []
      end

      display[point.y][point.x] = "X"
    end

    display.each do |row|
      r = row.map do |el|
        if el
          "X"
        else
          " "
        end
      end
      puts r.join("")
    end
    
  end  
end

# Day13.new(testfile).part_one
# Day13.new(file).part_one
# Day13.new(testfile).part_two
Day13.new(file).part_two
