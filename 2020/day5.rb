require 'pry-byebug'

testfile = File.open('input/day5-test.txt')
file = File.open('input/day5.txt')

class Seat
  attr_accessor :row, :column

  def initialize(code)
    # @row = get_row(code)
    # @column = get_column(code)
  end

  def seat_id(code)
    b = code.split("").map do |c|
      if c == "F" || c == "L"
        0
      else
        1
      end
    end
    b.join("").to_i(2)
    
  end

  def get_row(code)
    row_instructions = code[0...7]
    b = row_instructions.split("").map do |c|
      if c == "F"
        0
      else
        1
      end
    end
    b.join("").to_i(2)
  end


  def get_column(code)
    col_instructions = code[7...11]
    b = col_instructions.split("").map do |c|
      if c == "L"
        0
      else
        1
      end
    end
    b.join("").to_i(2)
  end

end


def seat_id(code)
  b = code.split("").map do |c|
    if c == "F" || c == "L"
      0
    else
      1
    end
  end
  b.join("").to_i(2)  
end

class Day5
  def initialize(f)
    @data = f.readlines.map do |line|
      # maybe do other stuff too 
      line.chomp
      #chomp chomp chomp
    end
  end

  def part_one
    seat_ids = []
    @data.each do |d|
      seat_ids.push(seat_id(d))
    end

    return seat_ids.max
  end

  def part_two
    seat_ids = []
    @data.each do |d|
      seat_ids.push(seat_id(d))
    end

    biggest_seat = seat_ids.max
    smallest_seat = seat_ids.min   
    
    all_seats = (smallest_seat..biggest_seat).to_a

    all_seats - seat_ids
  end
end

# puts Day5.new(testfile).part_one
# puts Day5.new(file).part_one
# Day5.new(testfile).part_two/
Day5.new(file).part_two
