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

(0..239).each do |cycle|
  position = cycle % 40
  signal_strength = signal_strengths.filter { |position, _| position <= cycle }.values.last
  signal_strength = 1 if signal_strength.nil?

  print ((position - 1..position + 1).include?(signal_strength) ? "#" : ' ')
  print "\n" if position == 39
end