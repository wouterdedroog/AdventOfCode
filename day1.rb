lines = File.open('inputs/day1.txt').readlines

elves = []
calories = 0
lines.each do |line|
  if line.strip.empty?
    elves.push(calories)
    calories = 0
  else
    calories += line.strip.to_i
  end
end
p elves.max               # part 1
p elves.sort.last(3).sum  # part 2