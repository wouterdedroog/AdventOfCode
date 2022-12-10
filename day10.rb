lines = File.open('inputs/day10.txt').readlines.map(&:chomp)
cycles = 0
signal_strength = 1
signal_strengths = {}

lines.each_with_index do |line, index|
  instruction, value = line.split
  if instruction == 'noop'
    cycles += 1
  elsif instruction == 'addx'
    cycles += 2
    signal_strength += value.to_i
    signal_strengths[cycles] = signal_strength
  end
end

p signal_strengths
p [20, 60, 100, 140, 180, 220].map { |cycle|
  signal_strengths.filter { |position, _| position < cycle }.values.last * cycle
}.sum
