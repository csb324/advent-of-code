input = File.read("daytwo_input.txt")

def get_wrapping_paper(presents_list)
  wrapping_paper = 0
  ribbon = 0
  presents = presents_list.split("\n")

  presents.each do |present|
    dimensions = present.split("x")
    dimensions.map! { |dimension| dimension.to_i }
    dimensions.sort!

    present_area = get_present_area(dimensions)
    ribbon_length = get_ribbon_length(dimensions)

    wrapping_paper += present_area
    ribbon += ribbon_length
  end

  puts "wrapping paper:"
  puts wrapping_paper
  puts
  puts "ribbon:"
  puts ribbon
end

def get_present_area(dimensions)
  present_area = 0
  present_area += (dimensions[0] * dimensions[1] * 3)
  present_area += (dimensions[1] * dimensions[2] * 2)
  present_area += (dimensions[2] * dimensions[0] * 2)
  present_area
end

def get_ribbon_length(dimensions)
  ribbon_length = 0
  ribbon_length += (dimensions[0] * dimensions[1] * dimensions[2])
  ribbon_length += (2 * (dimensions[0] + dimensions[1]))

  ribbon_length
end

get_wrapping_paper(input)
