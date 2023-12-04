require 'pry-byebug'
require 'set'

testfile = File.open('input/day8-test.txt')
file = File.open('input/day8.txt')

##### 5 characters and NOT a subset of 9 = 2 ?

##### 5 characters and full subset of 9 = 5

# 6 -- 6 characters and full superset of 5

# 0 -- 6 characters and full overlap with 1 but not 3

# segment frequency
  # a: 8
  # b: 6
  # c: 8 and it's in the 1
  # d: 7
  # e: 4
  # f: 8
  # g: 7
#end


class DigitDecoder
  def initialize(array_of_inputs)
    @code = {}

    sorted_array = array_of_inputs.sort_by(&:length).map do |el|
      el.split("").to_set
    end

    one_key = sorted_array.shift
    @code[set_to_key(one_key)] = 1
    seven_key = sorted_array.shift
    @code[set_to_key(seven_key)] = 7
    four_key = sorted_array.shift
    @code[set_to_key(four_key)] = 4

    eight_key = sorted_array.pop
    @code[set_to_key(eight_key)] = 8

    the_fives = sorted_array[0...3]
    the_sixes = sorted_array[3...6]
    three_key = the_fives.filter{|el| one_key.proper_subset?(el) }.first
    nine_key = the_sixes.filter{|el| three_key.proper_subset?(el) }.first
    @code[set_to_key(three_key)] = 3
    @code[set_to_key(nine_key)] = 9
    the_fives.delete(three_key)
    the_sixes.delete(nine_key)

    zero_key = the_sixes.filter{|el| one_key.proper_subset?(el)}.first
    @code[set_to_key(zero_key)] = 0
    the_sixes.delete(zero_key)
    six_key = the_sixes.first
    @code[set_to_key(six_key)] = 6

    five_key = the_fives.filter{ |el| el.proper_subset?(six_key)}.first
    the_fives.delete(five_key)
    @code[set_to_key(five_key)] = 5
    @code[set_to_key(the_fives.first)] = 2
  end

  def set_to_key(s)
    if(s.is_a? String) 
      s = s.split("")
    else
      s = s.to_a
    end

    s.sort.join("")
  end

  def decode(input)
    @code[set_to_key(input)]
  end

end

class Day8
  def initialize(f)
    @data = f.readlines.map do |line|
      # maybe do other stuff too 
      # line.chomp
      line.split("|").map(&:chomp)
      #chomp chomp chomp
    end
  end

  def part_two
    total = 0
    @data.each do |d|
      all_numbers = d[0].split(" ")
      displayed_numbers = d[1].split(" ")  

      decoder = DigitDecoder.new(all_numbers)

      decoded = ""
      displayed_numbers.each do |n|

        decoded << decoder.decode(n).to_s
      end
      total += decoded.to_i
    end

    puts total

  end

  def part_one
    count = 0

    @data.each do |d|
      displayed_numbers = d[1].split(" ")
      uniques = displayed_numbers.filter do |n|
        [2, 7, 3, 4].include? n.length
      end

      count += uniques.length
    end
    puts count 
  end  
end

# Day8.new(testfile).part_one
# Day8.new(file).part_one
# Day8.new(testfile).part_two
Day8.new(file).part_two
