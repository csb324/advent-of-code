require('pry-byebug')
testfile = File.open('input/day5-test.txt')
file = File.open('input/day5.txt')

class Line

  def initialize(x1:, y1:, x2:, y2:)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def is_straight?
    vertical? || horizontal?
  end

  def is_straight_or_diagonal?
    is_straight? || diagonal?
  end

  def to_s
    "#{@x1},#{@y1} to #{@x2},#{@y2} "
  end

  def vertical?
    @x1 == @x2
  end

  def horizontal?
    @y1 == @y2
  end

  def diagonal? 
    (@x1 - @x2).abs == (@y1 - @y2).abs
  end

  def cells
    result = []
    if(vertical?)
      start = [@y1, @y2].min 
      finish = [@y1, @y2].max

      (start..finish).to_a.each do |n|
        result.push("#{@x1},#{n}")
      end
    elsif (horizontal?)
      start = [@x1, @x2].min 
      finish = [@x1, @x2].max

      (start..finish).to_a.each do |n|
        result.push("#{n},#{@y1}")
      end
    else
      # definitely going positive in the x direction
      if(@x1 > @x2) 
        start_x = @x2
        finish_x = @x1
        start_y = @y2
        y_increment = (@y2 > @y1) ? -1 : 1
      else
        start_x = @x1
        finish_x = @x2
        start_y = @y1
        y_increment = (@y2 < @y1) ? -1 : 1
      end

      current_y = start_y

      (start_x..finish_x).to_a.each do |n|
        result.push("#{n},#{current_y}")
        current_y += y_increment
      end

    end

    result
  end

end

class Grid
  def initialize()
    @filled_cells = {}
  end

  def overlap_points
    @filled_cells.values.select{|v| v > 1}.count
  end

  def fill_cell(cell_id)

    if @filled_cells[cell_id]
      @filled_cells[cell_id] += 1
    else
      @filled_cells[cell_id] = 1
    end

  end

  def draw_line(line)
    line.cells.each do |c|
      fill_cell(c)
    end
  end
end

class Day5
  def initialize(f)
    filter = /(\d+),(\d+) -> (\d+),(\d+)/
    @lines = []
    @grid = Grid.new

    f.readlines.map do |line|
      # maybe do other stuff too 
      numbers = filter.match(line).captures     

      @lines.push(Line.new(
        x1: numbers[0].to_i,
        y1: numbers[1].to_i,
        x2: numbers[2].to_i,
        y2: numbers[3].to_i)
      )       
    end
  end

  def part_one

    @lines = @lines.filter(&:is_straight?)

    @lines.each do |l|
      @grid.draw_line(l)
    end

    puts @grid.overlap_points    
  end

  def part_two
    @lines = @lines.filter(&:is_straight_or_diagonal?)


    @lines.each do |l|
      @grid.draw_line(l)
    end

    puts @grid.overlap_points    
  end  
end

Day5.new(file).part_two