file = File.open('input/day1.txt')
depths = file.readlines.map(&:to_i)

scans = [];
depths.each_with_index do |d, i|
  if depths[i+2] 
    scans.push([d, depths[i+1], depths[i+2]])
  end
end

last = false
increases = 0

scans.each do |d| 
  
  if (last) 
    if (d.reduce(&:+) > last)
      increases += 1
    end
  end

  last = d.reduce(&:+)
end

puts increases
