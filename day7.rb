testfile = File.open('input/day7-test.txt')
file = File.open('input/day7.txt')

class Day7
  def initialize(f)
    lines = f.readlines.map do |line|
      # maybe do other stuff too 
      line.chomp
      #chomp chomp chomp
    end

    @crab_positions = lines[0].split(",").map(&:to_i)

    # @crab_positions = make_fake_crabs
  end

  def make_fake_crabs # used this to test a bunch of theories
    (0...45).map do |i|
      rand(200)
    end
  end

  def test_stupid(theory)
    min_fuel = 10000000
    (@crab_positions.min...@crab_positions.max).each do |n|
      fuel = get_fuel_needed(n)
      min_fuel = [min_fuel, fuel].min

      indicator = ""
      if(min_fuel == fuel)
        indicator = "***"
      end
      puts "Aligning at #{n} would take: #{fuel} fuel. #{indicator}"
    end

    if( theory == min_fuel)
      puts "ok!"
    else 
      puts "--------- OH NO ---------"
    end
  end

  def get_fuel_needed(target)
    total = 0
    @crab_positions.map {|c| (c - target).abs }.reduce(&:+)
  end

  def median(array)
    return nil if array.empty?
    sorted = array.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end

  def triangular( n ) # for part two fuel consumption
    n * (n + 1) / 2
  end

  def part_one
    puts get_fuel_needed(median(@crab_positions))
  end

  def get_part_two_fuel(target)
    @crab_positions.map {|c| triangular((c - target).abs) }.reduce(&:+)
  end

  def part_two
    min_fuel = 1000000000000
    theory = (@crab_positions.reduce(&:+) / (@crab_positions.length * 1.0)) # the mean

    theory_int = theory.round

    # the answer was pretty consistently within 1 of the mean,
    # so i brute forced it with a small range
    best_index = 0
    ((theory_int - 3)...(theory_int + 3)).each do |n|
      fuel = get_part_two_fuel(n)
      min_fuel = [min_fuel, fuel].min

      indicator = ""
      if(min_fuel == fuel)
        best_index = n
      end
      # puts "Aligning at #{n} would take: #{fuel} fuel. #{indicator}"
    end

    if(get_part_two_fuel(theory_int) == min_fuel)
      puts "yepppp."
    else
      puts "------- NOPE -------. Actually, #{best_index}"
    end

    puts "theory was: #{theory} rounded to #{theory_int} and the fuel for that was #{get_part_two_fuel(theory_int)}"

    # puts "THE ANSWER IS: #{min_fuel}"
  end  
end

# Day7.new(testfile).part_one
# Day7.new(file).part_one
# 20.times do 
  # Day7.new(testfile).part_two
# end

Day7.new(file).part_two
