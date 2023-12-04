require 'pry-byebug'
testfile = File.open('input/day10-test.txt')
file = File.open('input/day10.txt')


class NavCommand
  attr_accessor :score 
  def initialize(s)
    @commands = s
    @score = 0
  end

  def is_corrupted?
    pairs = {
      "<" => ">",
      "(" => ")",
      "[" => "]",
      "{" => "}"
    }

    scores = {
      ">" => 25137,
      ")" => 3,
      "]" => 57,
      "}" => 1197
    }

    

    openers = []

    @commands.split("").each do |ch|
      if (pairs.keys.include? ch)
        openers.push(ch)
      else
        current_scope = openers.pop
        unless pairs[current_scope] == ch
          @score = scores[ch]
          return true
        end
      end
    end

    score_autocompletes(openers)

    false

  end

  def score_autocompletes(openers)
    autocomplete_scores = {
      "(" => 1,
      "[" => 2,
      "{" => 3,
      "<" => 4
    }

    @score = 0

    # binding.pry

    while (openers.length > 0)
      ch = openers.pop
      @score *= 5
      @score += autocomplete_scores[ch]
      # puts @score
    end
  end

end

class Day10
  def initialize(f)
    @commands = f.readlines.map do |line|
      # maybe do other stuff too 
      NavCommand.new(line.chomp)
      #chomp chomp chomp
    end
  end

  def part_one

    corrupted = @commands.filter(&:is_corrupted?)

  end

  def part_two
    incompletes = @commands.reject(&:is_corrupted?)
    sorted = incompletes.sort_by(&:score)
    
    middle_index = (sorted.length / 2.0).floor

    puts sorted[middle_index].score
  end  
end

# Day10.new(testfile).part_one
# Day10.new(file).part_one
# Day10.new(testfile).part_two
Day10.new(file).part_two
