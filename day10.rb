lines = File.open('inputs/day10.txt').readlines.map(&:chomp)
cycles = 0
signal_strengths = {}
signal_strengths[0] = 1

lines.map(&:split).each do |instruction, value|
  case instruction
  when 'addx'
    cycles += 2
    signal_strengths[cycles] = signal_strengths.values.last + value.to_i
  else
    cycles += 1
  end
end

# pt1
sum_of_six_signal_strengths = [20, 60, 100, 140, 180, 220].map { |cycle|
  signal_strengths.filter { |position, _| position < cycle }.values.last * cycle
}.sum
puts "The sum of the six signal strengths is #{sum_of_six_signal_strengths}"

# pt2
(0..239).each do |cycle|
  position = cycle % 40
  signal_strength = signal_strengths.filter { |strength_position, _| strength_position <= cycle }.values.last

  print((position - 1..position + 1).include?(signal_strength) ? '#' : ' ')
  print("\n") if position == 39
end
