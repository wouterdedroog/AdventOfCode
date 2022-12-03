lines = File.open('inputs/day3.txt').readlines

def get_priority(char)
  if char.upcase == char
    char.ord - 38
  else
    char.ord - 96
  end
end

def split_into_parts(string)
  [string[0, string.length/3], string[string.length/3, string.length/3], string[string.length/3*2, string.length/3*3]]
end

priority_sum = 0
lines.each_slice(3).each_with_index do |lines, index|
  first,second,third = lines.map(&:chomp)
  duplicate = first.chars.select{|char| second.include?(char) && third.include?(char)}.first
  priority_sum += get_priority(duplicate)
end
p priority_sum

