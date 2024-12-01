lines = File.open('inputs/day1.txt').readlines

first, second = lines.map { |line| line.split('   ').map(&:to_i) }.transpose

puts "part 2: #{first.map { |x| x * second.count(x) }.sum}"

result = first.sort.map do |first_min|
  second_min = second.min
  second.delete_at(second.index(second_min))

  (second_min - first_min).abs
end.sum

puts "part 1: #{result}"
