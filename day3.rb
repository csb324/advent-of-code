require 'pry-byebug'
testfile = File.open('input/day3-test.txt')
file = File.open('input/day3.txt')

class Day3
  def initialize(f)
    @data = f.readlines.map do |line|
      line.chomp
    end
  end

  def part_one
    reading_length = @data[0].length
    @gamma = []
    @epsilon = []

    reading_length.times do |i|
      groups = @data.group_by { |d| d[i] }.map do |k, v| 
        [k, v.count]
      end
      groups = groups.sort_by(&:last).reverse
      @gamma.push(groups.first.first)
      @epsilon.push(groups.last.first)
    end

    @gamma = @gamma.join("").to_i(2)
    @epsilon = @epsilon.join("").to_i(2)
    puts @gamma
    puts @epsilon

    puts "and the answer is: #{@gamma * @epsilon}"
  end

  def part_two
    # @oxygen_rating 
    reading_length = @data[0].length
    @oxygen = []
    @co2 = []

    oxygen_data = @data
    carbon_data = @data 

    reading_length.times do |i|
      oxygen_data = oxygen_data.filter { |d| d.start_with?(@oxygen.join("") )}

      o_groups = oxygen_data
        .group_by { |d| d[i] }
        .map do |k, v| 
          [k, v.count]
        end

      o_groups = o_groups.sort_by { |g| [g.last, g.first.to_i] }
      @oxygen.push(o_groups.last.first)

      carbon_data = carbon_data.filter { |d| d.start_with?(@co2.join("") )}
      c_groups = carbon_data
        .group_by { |d| d[i] }
        .map do |k, v| 
          [k, v.count]
        end

      c_groups = c_groups.sort_by { |g| [g.last, g.first.to_i] }
      @co2.push(c_groups.first.first)
    end

    @oxygen = @oxygen.join("").to_i(2)
    @co2 = @co2.join("").to_i(2)

    puts "and the answer is: #{@oxygen * @co2}"

  end
end

# Day3.new(testfile).part_one
# Day3.new(file).part_one

Day3.new(file).part_two