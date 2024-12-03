import re

input=open('inputs/day3.txt').read().replace('\n', '')

sum = 0

matches = re.findall(r'mul\((\d{1,3}),(\d{1,3})\)', input)
for match in matches:
    sum += int(match[0]) * int(match[1])

print("part 1: " + str(sum))

# pt2
input = "do()" + input + "don't()"
sum = 0

do_groups = re.findall(r"do\(\).*?don't\(\)", input)
for do_group in do_groups:
    matches = re.findall(r'mul\((\d{1,3}),(\d{1,3})\)', do_group)
    for match in matches:
        sum += int(match[0]) * int(match[1])

print("part 2: " + str(sum))