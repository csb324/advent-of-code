require 'pry-byebug'
testfile = File.open('input/day4-test.txt')
file = File.open('input/day4.txt')

class BingoBoard
  def initialize(lines)
    @numbers = lines.each_with_index.map do |l, x|
      l.split(" ").each_with_index.map do |i, y|
        {
          called: false,
          number: i.to_i,
          x: x,
          y: y
        }
      end
    end

    @numbers.flatten!

    @has_won = false
  end

  def call_number(number)
    return if @has_won
    
    found = @numbers.select { |n| n[:number] == number }.first
    return unless found

    found[:called] = true
  end

  def check_row(id)
    r = @numbers.select { |n| n[:x] == id && n[:called] }
    return r.length == 5
  end

  def check_col(id)
    r = @numbers.select { |n| n[:y] == id && n[:called] }
    return r.length == 5
  end

  def win?
    return @has_won if @has_won

    5.times do |i|
      @has_won = true if check_row(i) or check_col(i)
    end

    @has_won
  end

  def score
    scorable = @numbers.reject { |n| n[:called] }.map{|n| n[:number]}
    scorable = scorable.reduce(&:+)

    scorable
  end

end

class Day4
  def initialize(f)
    data = f.readlines.map do |line|
      line.chomp
    end

    @numbers_to_call = data.shift.split(",").map(&:to_i)

    @bingo_boards = []
    while (data.length > 1) do
      data.shift()
      @bingo_boards.push(BingoBoard.new(data.shift(5)))
    end
  end

  def part_one

    @numbers_to_call.each do |n|
      @bingo_boards.each do |b|
        b.call_number(n)
        if(b.win?) 
          return b.score * n
        end
      end
    end

  end

  def part_two

    order_of_winning = []
    remaining_bingo_boards = @bingo_boards

    last_n = 0

    @numbers_to_call.each do |n|
      remaining_bingo_boards = remaining_bingo_boards.reject do |b|
        b.win?
      end

      remaining_bingo_boards.each do |b|
        b.call_number(n)
      end

      if(remaining_bingo_boards.length == 1 && remaining_bingo_boards[0].win?)
        score =  remaining_bingo_boards[0].score
        puts score * n
        return score
      end

    end

  end  
end


puts Day4.new(file).part_two