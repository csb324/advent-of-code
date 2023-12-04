import re

class Game:
  def __init__(self, textDefinition):    
    self.index = self.parseIndex(textDefinition)
    self.rounds = self.initRounds(textDefinition)
    self.getMost()
  
  def parseIndex(self, text):
    m = re.search("Game (\d+)", text)
    return int(m.group(1))
  
  def getMost(self):
     # mostRed meaning: "the most red cubes i've seen at once"
    self.mostRed = 0
    self.mostGreen = 0
    self.mostBlue = 0
    
    for r in self.rounds:
      if r['red'] > self.mostRed:
        self.mostRed = r['red']
      if r['green'] > self.mostGreen:
        self.mostGreen = r['green']
      if r['blue'] > self.mostBlue:
        self.mostBlue = r['blue']

  def initRounds(self, text):
    roundsText = text.split(": ")[1] # everything after the :
    roundsText = roundsText.split(";") 

    # print(roundsText) # now it's a list of strings
    # something like: ['3 blue, 4 red', ' 1 red, 2 green, 6 blue', ' 2 green']
    # but that still isn't what we want!

    rounds = []
    for revealedCubes in roundsText:
      result = {
        'red': 0,
        'green': 0,
        'blue': 0
      }

      # there's probably a more elegant way to do the below but this is pretty readable
      red = re.search("(\d+) red", revealedCubes)
      if red:        
        result['red'] = int(red.group(1))

      green = re.search("(\d+) green", revealedCubes)
      if green:        
        result['green'] = int(green.group(1))

      blue = re.search("(\d+) blue", revealedCubes)
      if blue:        
        result['blue'] = int(blue.group(1))

      rounds.append(result)

    print(rounds)
    return rounds
  
  def couldItBe(self, cubeSet):
    if(cubeSet['red'] < self.mostRed):
      return False
    if(cubeSet['green'] < self.mostGreen):
      return False
    if(cubeSet['blue'] < self.mostBlue):
      return False
    
    return True
  
  def getPower(self):
    return self.mostBlue * self.mostGreen * self.mostRed

def partOne():
  file = open('./input/day2.txt')
  total =  0
  for line in file.readlines():
    g = Game(line.strip())
    if(g.couldItBe({'red': 12, 'green': 13, 'blue': 14})):
      total += g.index

  print(total)
  return total

def partTwo():
  file = open('./input/day2.txt')
  totalPower =  0
  for line in file.readlines():
    g = Game(line.strip())
    totalPower += g.getPower()

  print(totalPower)
  return totalPower


partTwo()