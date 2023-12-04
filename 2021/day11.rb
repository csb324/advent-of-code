require 'colorize'
require 'pry-byebug'

testfile = File.open('input/day11-test.txt')
file = File.open('input/day11.txt')

class Octopus
  attr_reader :x, :y, :energy

  def initialize(x, y, energy)
    @x = x
    @y = y

    @energy = energy
    @flashing = false

    @neighbors = []
  end

  def assign_neighbors(list)
    @neighbors = list
  end

  def increment
    @energy += 1    
  end

  def feel_neighbor
    increment
    flash
  end

  def flash
    return if @energy <= 9 || @flashing

    @flashing = true
    @neighbors.each{|n| n.feel_neighbor }
  end

  def clean
    if @flashing
      @flashing = false
      @energy = 0
      1
    else
      0
    end
  end

  def visualize
    if @flashing
      "F".colorize(:green)
    else
      @energy.to_s
    end
  end

end

class Day11
  def initialize(f)
    @octopodes = f.readlines.each_with_index.map do |line, line_no|
      # maybe do other stuff too 
      line.chomp.split("").map(&:to_i).each_with_index.map do |i, col_no|
        Octopus.new(col_no, line_no, i)
      end
    end

    @octopodes.flatten.each do |octo|
      octo.assign_neighbors(get_neighbors(octo.y, octo.x))
    end

  end

  def get_octo(row_number, col_number) 
    return if row_number < 0 || col_number < 0
    return if row_number >= @octopodes.length || col_number >= @octopodes[0].length
    
    @octopodes[row_number][col_number]
  end

  def get_neighbors(row_number, col_number)
    possible_neighbors = [
      get_octo(row_number - 1, col_number),
      get_octo(row_number - 1, col_number - 1),
      get_octo(row_number - 1, col_number + 1),
      get_octo(row_number + 1, col_number),
      get_octo(row_number + 1, col_number - 1),
      get_octo(row_number + 1, col_number + 1),
      get_octo(row_number, col_number - 1),
      get_octo(row_number, col_number + 1)
    ]

    neighbors = possible_neighbors.reject{|el| el == nil }
    neighbors
  end

  def step_octos
    flats = @octopodes.flatten
    flats.each do |octo|
      octo.increment
    end
    flats.each do |octo|
      octo.flash
    end

    flats.map{ |octo| octo.clean }.reduce(&:+)
  end

  def visualize
    @octopodes.each do |row|
      puts row.map(&:visualize).join("")
    end
  end

  def part_one
    flashes = 0
    100.times do 
      flashes += step_octos
    end
    puts flashes
  end

  def part_two

    step_counter = 0
    found = false
    while(found == false) do 
      step_counter += 1
      flashing = step_octos
      found = (flashing == @octopodes.flatten.length)
    end

    puts step_counter

  end  
end

# Day11.new(testfile).part_one
# Day11.new(file).part_one
# Day11.new(testfile).part_two
Day11.new(file).part_two
