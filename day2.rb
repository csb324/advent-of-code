file = File.open('input/day2.txt')

class Submarine
  def initialize(file)
    @directions = file.readlines.map do |line|
      data = line.split(" ")
      {
        direction: data[0],
        amount: data[1].to_i
      }
    end
    
    @current_depth = 0
    @current_x = 0
    @aim = 0
    # get_position_part1
    get_position
  end

  def read_direction(i)
    case i[:direction]
    when 'forward'
      @current_x += i[:amount]
      @current_depth += (@aim * i[:amount])
    when 'up'
      @aim -= i[:amount]
    when 'down'
      @aim += i[:amount]
    end

  end

  def get_position
    @directions.each do |d|
      # read_direction_part1(d)
      read_direction(d)
    end

    puts "Depth is #{@current_depth}"
    puts "X is #{@current_x}"

    puts "multiplied is #{@current_depth * @current_x}"    
  end

  def read_direction_part1(i)
    case i[:direction]
    when 'forward'
      @current_x += i[:amount]
    when 'up'
      @current_depth -= i[:amount]
    when 'down'
      @current_depth += i[:amount]
    end
  end

end

Submarine.new(file)