lines = File.open('inputs/day1.txt').readlines

first, second = lines.map { |line| line.split('   ').map(&:to_i) }.transpose.map(&:sort)

puts "part 1: #{first.map.with_index { |first_min, i| (second[i] - first_min).abs }.sum}"
puts "part 2: #{first.map { |x| x * second.count(x) }.sum}"
