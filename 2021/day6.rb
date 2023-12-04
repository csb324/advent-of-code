testfile = File.open('input/day6-test.txt')
file = File.open('input/day6.txt')

class Lanternfish
  def initialize(list:, countdown: 9)
    @countdown = countdown    
    @list = list
    @list.push(self)
  end

  def mark_day
    @countdown -= 1
    if(@countdown < 0)
      @countdown = 6
      Lanternfish.new(list: @list)
    end
  end

  def to_s
    @countdown
  end
end

class Day6
  def initialize(f)

    lines = f.readlines.map do |line|
      # maybe do other stuff too 
      line.split(",").map(&:to_i)
      #chomp chomp chomp
    end

    @list = []
    @input = lines[0]

    lines[0].each do |n|
      Lanternfish.new(list: @list, countdown: n)
    end

  end

  def part_one
    80.times do |i|
      these_fish = @list
      these_fish.each do |f|
        f.mark_day
      end
      # puts "After #{i+1} days: #{@list.map(&:to_s).join(",")}"      
    end

    puts @list.count 

  end

  def part_two
    how_many_fish = @list.count
    how_many_days = 256

              # | s  m  t  w  t  f  s | 
    fish_cycles = [0, 0, 0, 0, 0, 0, 0]
    index_cycle = [0, 1, 2, 3, 4, 5, 6]
    
    @input.each do |i|
      fish_cycles[i] += 1
    end

    days = 0
    
    eggs = 0
    hatchlings = 0

    index_cycle.cycle do |el|
      new_number = hatchlings

      hatchlings = eggs
      eggs = fish_cycles[el]

      fish_cycles[el] += new_number
      # puts fish_cycles.join(",")
      days += 1
      break if(days == how_many_days)
    end

    puts fish_cycles.reduce(&:+) + eggs + hatchlings

  end
end

# Day6.new(testfile).part_one
# Day6.new(file).part_one
# Day6.new(testfile).part_two
Day6.new(file).part_two
