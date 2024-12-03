lines = File.open('inputs/day2.txt').readlines
            .map { |line| line.split(' ').map(&:to_i) }

def line_valid(line)
  delta_arr = line[0..-2].map.with_index { |x, i| x - line[i + 1] }

  (delta_arr.all?(&:positive?) or delta_arr.all?(&:negative?)) and delta_arr.all? { |x| x.abs >= 1 && x.abs <= 3 }
end

puts "Part 1 #{lines.filter { |line| line_valid(line) }.count}"

part2 = lines.map do |line|
  (0..line.count).map { |i| clone = line.clone; clone.delete_at(i); clone }
                 .find { |option| line_valid(option) }
end
puts "Part 2 #{part2.compact.count}"