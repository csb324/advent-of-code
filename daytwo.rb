input = File.read("daytwo_input.txt")

def get_wrapping_paper(presents_list)
  wrapping_paper = 0
  presents = presents_list.split("\n")

  presents.each do |present|
    present_area = 0
    dimensions = present.split("x")
    dimensions.map! { |dimension| dimension.to_i }
    dimensions.sort!

    present_area += (dimensions[0]*dimensions[1]*3)
    present_area += (dimensions[1]*dimensions[2]*2)
    present_area += (dimensions[2]*dimensions[0]*2)

    wrapping_paper += present_area
  end

  puts wrapping_paper
end

get_wrapping_paper(input)
