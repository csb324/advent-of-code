require('open-uri')
require('erb')

class Advent 



  def initialize(day)

    File.open("./day#{day}.rb", "wb") do |file|
      file.write(write_scaffold(day))
    end
    File.open("./input/day#{day}-test.txt", "wb") do |file|
      file.write("")
    end

    File.open("./input/day#{day}.txt", "wb") do |file|
      file.write("go to https://adventofcode.com/2021/day/#{day}/input")
    end

  end

  def write_scaffold(day)
    number = day
    ERB.new(File.read('./scaffold.erb')).result_with_hash(:number => day)
  end


end

Advent.new(ARGV[0].to_i)