import re

def get_first_digit(calibration_string):
  # what is this dark magic??
  # it's regular expressions!  

  # here's the python documentation
  # https://docs.python.org/3/library/re.html#re-objects

  # and here's a website i use LIBERALLY:
  # https://regex101.com/

  # ROUGHLY TRANSLATED
  # ^           means: the beginning of the string
  # \D*?        means: any number of non-digit characters, where "any number" means zero is also a number
  # parentheses means: capture this part in `groups`
  # \d          means: a digit character

  first_search = re.search("^\D*?(\d)", calibration_string)
  first_digit = int(first_search.groups()[0])
  return first_digit

def get_last_digit(calibration_string):
    # this is the same logic in reverse!
    # $ means: the end of the string

  last_search = re.search("(\d)\D*?$", calibration_string)
  last_digit = int(last_search.groups()[0])
  return last_digit

def get_digits(calibration_string):
  first_digit = get_first_digit(calibration_string)
  last_digit = get_last_digit(calibration_string)

  # then, simple math
  return (10 * first_digit) + last_digit

def part_one():
  file = open('./input/day1.txt', 'r')

  total = 0
  for line in file.readlines():
    line = line.strip()
    total += get_digits(line)

  print(total)


def match_to_number(regex_match):
    dictionary = {
      'one': 1,
      'two': 2,
      'three': 3,
      'four': 4,
      'five': 5,
      'six': 6,
      'seven': 7,
      'eight': 8,
      'nine': 9
    }

    m = regex_match.group(0)
    reverse_m = "".join(reversed(regex_match.group(0)))

    if m in dictionary:
      return str(dictionary[m])
    elif reverse_m in dictionary:
      return str(dictionary[reverse_m])
    else:
      print("AAA OH NO")


def part_two():
  file = open('./input/day1.txt', 'r')

  total = 0

  # hmmmmmm
  # my first thought: first, loop through the input and replace all written-digits with their number counterpart
  # then use the same function from above
  # HOWEVER, the test input has this string: xtwone34
  # and in that one, i care about the 'two', not the 'one', BUT they share a letter
  # so i will have to be moderately clever about this. 

  # regular expressions don't find overlapping matches, so they would only catch the "two" in the above case
  # which is fine in that case, but consider a string like "12346sevenine"
  # in that situation, we actually want to know about the "nine" but the "seven" would block us from seeing it

  # and what if the string were just sevenine? we would want the 7 on first pass and 9 on second pass.

  for line in file.readlines():

    line = line.strip()
    line_for_last_digit = line  # create a copy so we can do different things to prepare for 
                                # finding-first-match and finding-last-match

    text_digits = re.findall("(one|two|three|four|five|six|seven|eight|nine)", line)

    if(text_digits):
      # substitute the FIRST text-number with its digit counterpart (that part is easy)
      line = re.sub("(one|two|three|four|five|six|seven|eight|nine)", match_to_number, line, 1)


      # then, let's just reverse the whole thing so we can get the final digit properly
      line_for_last_digit = "".join(reversed(line_for_last_digit))
      # then swap the first match for its digit partner
      line_for_last_digit = re.sub("(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno)", match_to_number, line_for_last_digit, 1)
      # then re-reverse so first = last again 
      line_for_last_digit = "".join(reversed(line_for_last_digit))


    tens_place =  get_first_digit(line)
    ones_place = get_last_digit(line_for_last_digit)


    print(tens_place, ones_place)

    total += tens_place * 10
    total += ones_place

  print(total)

part_two()