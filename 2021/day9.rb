require 'colorize'
require 'pry-byebug'


testfile = File.open('input/day9-test.txt')
file = File.open('input/day9.txt')

class MapReader
  def initialize(data)
    @map = data.each_with_index.map do |r, r_n|
      r.each_with_index.map do |c, c_n|
        { depth: c, row_number: r_n, col_number: c_n, no_basin: c == 9 }
      end
    end
    
    init_lows
  end

  def visualize

    init_basins

    @map.each_with_index do |row, row_number|
      colorized = row.each_with_index.map do |el, col_number|
        if el[:is_low_point]
          el[:depth].to_s.colorize(:green)
        elsif el[:basin]
          el[:depth].to_s.colorize(:blue)
        elsif(el[:depth] == 9) 
          el[:depth].to_s.colorize(:red)
        else
          el[:depth].to_s
        end
      end
      puts colorized.join("")
    end
  end

  def get_basinmates(points_to_check)
    next_round = []

    points_to_check.each do |point|
      neighbors = get_neighbors(point[:row_number], point[:col_number])
      neighbors.each do |n|
        unless n[:no_basin] || n[:basin]
          n[:basin] = point[:basin]
          next_round.push(n)
        end
      end
    end

    get_basinmates(next_round) if next_round.length > 0
  end

  def init_basins
    @lows.each do |low_point|
      get_basinmates([low_point])
    end

    list_of_basins = @map.flatten.reject{|e| e[:no_basin]}.group_by{|el| el[:basin]}
    organized = list_of_basins.values.map(&:length)
    puts organized.sort!.reverse[0...3].reduce(&:*)
  end

  def get_depth_at(row_number, col_number) 
    return if row_number < 0 || col_number < 0
    return if row_number >= @map.length || col_number >= @map[0].length
    
    @map[row_number][col_number]
  end

  def get_neighbors(row_number, col_number)
    up = get_depth_at(row_number - 1, col_number)
    down = get_depth_at(row_number + 1, col_number)
    left = get_depth_at(row_number, col_number - 1)
    right = get_depth_at(row_number, col_number + 1)

    neighbors = [up, down, left, right].reject{|el| el == nil }

    neighbors
  end

  def init_lows
    @lows = []

    @map.each_with_index do |row, row_number|
      row.each_with_index do |item, col_number|
        ns = get_neighbors(row_number, col_number).map{|el| el[:depth] }
        if item[:depth] < ns.min         
          item[:basin] = "#{row_number},#{col_number}"
          item[:is_low_point] = true
          
          @lows.push(item)
        end
      end
    end

  end

  def lows 
    @lows
  end
end

class Day9
  def initialize(f)
    @data = f.readlines.map do |line|
      line.chomp.split("").map(&:to_i)
    end

  end

  def part_one
    m = MapReader.new(@data)
    l = m.low_points

    puts l.map{|el| el[:val] + 1}.reduce(&:+)
  end

  def visualize
    m = MapReader.new(@data)
    m.visualize
  end

  def part_two
    m = MapReader.new(@data)
    m.init_basins
    

  end  
end

# Day9.new(testfile).part_one
# Day9.new(file).part_one
# Day9.new(testfile).part_two
Day9.new(file).visualize
