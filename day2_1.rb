lines = File.open('inputs/day2.txt').readlines

definitions = {
  'A' => 'Rock',
  'B' => 'Paper',
  'C' => 'Scissors',
  'X' => 'Rock',
  'Y' => 'Paper',
  'Z' => 'Scissors'
}

strategies = {
  'Rock' => 'Paper',
  'Paper' => 'Scissors',
  'Scissors' => 'Rock'
}

points = 0
lines.each do |line|
  opponent = definitions[line.chars[0]]
  response = definitions[line.chars[2]]

  points += strategies.find_index { |k,_| k == response } + 1 # add points based on the index of the move I played

  case response
    when opponent # draw
      points += 3
    when strategies[opponent] # i won
      points += 6
  end
end
p points
