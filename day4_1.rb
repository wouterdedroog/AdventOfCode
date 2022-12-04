lines = File.open('inputs/day4.txt').readlines

pair_count = 0
lines.each do |line|
  range1, range2 = line.chomp.split(',').map{ |r| r.split('-').map(&:to_i) }.map { |x, y| (x..y).to_a }
  pair_count += 1 if range1.all? { |e| range2.include?(e) } || range2.all? { |e| range1.include?(e) }
end
p pair_count

