lines = File.open('inputs/day4.txt').readlines

pair_count = 0
lines.each do |line|
  range1, range2 = line.chomp.split(',').map{ |r| r.split('-').map(&:to_i) }.map { |x, y| (x..y).to_a }
  pair_count += 1 unless range1.intersection(range2).empty?
end
p pair_count
