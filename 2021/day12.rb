require 'pry-byebug'
testfile = File.open('input/day12-test.txt')
file = File.open('input/day12.txt')

# class Path

class Walker
  attr_accessor :paths
  def initialize(cave_map)
    @paths = []
    @cave_map = cave_map

    continue_path
  end

  def has_hit_small_caves(visited)
    # return true
    smalls = visited.reject do |c|
      c == "start" || c == "end" || c =~ /[A-Z]+/
    end
    
    smalls.length == 0 || smalls.tally.values.max > 1
  end

  def continue_path(visited: ["start"])  
    starting_point = @cave_map[visited.last]

    if starting_point.name == "end"
      @paths.push(visited)
      puts "this is one valid path"
      puts visited.join(" -> ")
    else

      next_steps = starting_point.neighbors.clone
  
      if (has_hit_small_caves(visited))
        next_steps.reject! do |c|
          visited.include?(c.name) && !c.uppercase
        end
      else
        next_steps.reject! do |c|
          c.name == "start"
        end
      end
    
      # puts "current next steps are: #{next_steps.map(&:name).join(", ")}"
      next_steps.each do |n|
        continue_path(visited: visited.clone.append(n.name))
      end  
    end

  end
end


class Cave
  attr_accessor :name, :neighbors, :uppercase

  def initialize(name)
    @name = name
    @neighbors = []
    @uppercase = (@name =~ /[A-Z]+/)
  end

  def add_edge(neighbor)
    # puts "adding neighbor #{neighbor.name} to #{@name}"
    @neighbors << neighbor
    # puts "I now have #{@neighbors.length} neighbors"
  end
end


class Day12
  def initialize(f)
    @map = {}

    f.readlines.map do |line|
      caves = line.chomp.split("-")

      first_cave = @map[caves[0]]
      second_cave = @map[caves[1]]

      if !first_cave
        @map[caves[0]] = Cave.new(caves[0])
        first_cave = @map[caves[0]]
      end

      if !second_cave
        @map[caves[1]] = Cave.new(caves[1])
        second_cave = @map[caves[1]]
      end

      first_cave.add_edge(second_cave)
      second_cave.add_edge(first_cave)

    end
  end

  def part_one
    w = Walker.new(@map)

    puts w.paths.length

    # binding.pry

  end

  def part_two
    w = Walker.new(@map)

    puts w.paths.length

  end  
end

# Day12.new(testfile).part_one
# Day12.new(file).part_one
# Day12.new(testfile).part_two
Day12.new(file).part_two
