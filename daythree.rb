file = File.read("daythree_input.txt")

def get_houses(input)
  directions = input.split("")
  santa_x = 0
  santa_y = 0
  robo_x = 0
  robo_y = 0

  robot = true

  houses = {}

  directions.each do |direction|
    if robot
      if direction == "^"
        robo_y -= 1
      elsif direction == "v"
        robo_y += 1
      elsif direction == "<"
        robo_x -= 1
      elsif direction == ">"
        robo_x += 1
      end
      house = "#{robo_x},#{robo_y}"
    else
      if direction == "^"
        santa_y -= 1
      elsif direction == "v"
        santa_y += 1
      elsif direction == "<"
        santa_x -= 1
      elsif direction == ">"
        santa_x += 1
      end
      house = "#{santa_x},#{santa_y}"
    end


    if houses[house]
      houses[house] += 1
    else
      houses[house] = 1
    end

    robot = !robot
  end
  puts houses.length
end

get_houses(file)
