lines = File.open('inputs/day3.txt').readlines

def get_priority(char)
  if char.upcase == char
    char.ord - 38
  else
    char.ord - 96
  end
end

priority_sum = 0
lines.each_with_index do |line, index|
  first,second = line.partition(/.{#{line.size/2}}/)[1,2]
  duplicate = first.chars.select{|char| second.include? char}.first
  priority_sum += get_priority(duplicate)
end
p priority_sum