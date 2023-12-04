import re 

class Schematic:
  def __init__(self):

    file = open('./input/day3.txt', 'r')
    lines = file.readlines()

    self.directoryOfNumbers = {}

    self.symbolLocations = []

    self.gearLocations = []

    # step one: turn the map into a 2d list
    self.rawMap = []

    lineNumber = 0
    self.partID = 0

    for l in lines:
      # first of all, make a dictionary o' numbers
      l = l.strip()
      self.rawMap.append(l)

      # step two: make a list of which cells contain numbers
      self.mapSymbols(l, lineNumber)
      self.mapNumbers(l, lineNumber)
      
      lineNumber += 1
  
  def mapNumbers(self, l, lineNumber):
    numbers = re.finditer("\d+", l)
    for n in numbers:
      record = {
        'partID': self.partID,
        'value': int(n.group(0))
      }

      self.partID += 1
      for x in range( n.start(), n.end()):
        self.directoryOfNumbers[lineNumber, x] = record

  def mapSymbols(self, l, lineNumber):
    symbolMatches = re.finditer("[^\.\d\s]", l)

    for m in symbolMatches:
      self.symbolLocations.append([lineNumber, m.start()])
      if(m.group(0) == "*"):
        self.gearLocations.append([lineNumber, m.start()])


  def getAdjacentPoints(self, locationTuple):
    adjacentPoints = []
    for dx in range(-1, 2):  # d as in delta -- we want x-1, x+0, and x+1 
      for dy in range(-1,2): # ditto
        adjacentPoints.append([locationTuple[0] + dx, locationTuple[1] + dy])

    return adjacentPoints
  
  def identifyGears(self):
    total = 0
    for g in self.gearLocations:
      neighbors = self.getAdjacentPoints(g)
      neighborParts = []
      for location in neighbors:

        if tuple(location) in self.directoryOfNumbers:
          part = self.directoryOfNumbers[tuple(location)]
          if part not in neighborParts:
            neighborParts.append(part)
      
      if len(neighborParts) == 2:
        print("YASS GEAR")
        total += (neighborParts[0]['value'] * neighborParts[1]['value'])
      else: 
        print("nooo gear")

    return total

  def getAllValidParts(self):
    print(self.directoryOfNumbers)

    locationsToCheck = []
    parts = []

    print("there are", len(self.symbolLocations), "symbols")

    for pair in self.symbolLocations:
      locationsToCheck += self.getAdjacentPoints(pair)

    for location in locationsToCheck:
      if location == [4, 113]:
        print(self.directoryOfNumbers[4, 113])

      if tuple(location) in self.directoryOfNumbers:
        part = self.directoryOfNumbers[tuple(location)]

        if part not in parts:
          # print("new part!!!!!")
          # print(location)
          # print(part)

          parts.append(part)

    parts.sort(key=lambda p: p['partID'])
    return parts

  def getPartsSum(self):
    parts = self.getAllValidParts()
    # print(parts)
    total = 0

    for p in parts:      
      total += p['value']

      print("adding", p['value'], "for a total of", total)

    return total
  

  def debugPartsSum(self):
    debugDictionary = {}
    missingDictionary = {}
    parts = self.getAllValidParts()

    everyPart = list(self.directoryOfNumbers.values())

    for p in everyPart:
      v = False
      if p in parts:
        v = True

      debugDictionary[p['partID']] = {
        'value': p['value'],
        'isValid': v
      }

      if not v:
        missingDictionary[p['partID']] = p['value']


    for m in list(missingDictionary.values()):
      print(m)

s = Schematic()


print(s.identifyGears())
# s.debugPartsSum()

# print(s.symbolLocations)
# print(s.directoryOfNumbers)
# print(s.rawMap)