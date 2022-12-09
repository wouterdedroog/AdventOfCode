lines = File.open('inputs/day9.txt').readlines.map(&:chomp)

visited_positions = []
previous_position = [[0, 0], [0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0],[0, 0]]

def should_move_tail(head_x, head_y, tail_x, tail_y)
  (head_x - tail_x).abs > 1 || (head_y - tail_y).abs > 1
end

def get_tail_position(head_x, head_y, tail_x, tail_y)
  return [tail_x, tail_y] unless should_move_tail(head_x, head_y, tail_x, tail_y)

  diff_x = head_x - tail_x
  diff_y = head_y - tail_y

  if diff_x.abs >= 1
    tail_x += diff_x.positive? ? 1 : -1
  end
  if diff_y.abs >= 1
    tail_y += diff_y.positive? ? 1 : -1
  end

  [tail_x, tail_y]
end

lines.map { |line| line.split(' ')[0..1] }.each do |line|
  movement = line[0]
  steps = line[1].to_i

  head_x, head_y = previous_position[0][0..1]

  steps.times do
    head_y += 1 if movement == 'U'
    head_y -= 1 if movement == 'D'
    head_x += 1 if movement == 'R'
    head_x -= 1 if movement == 'L'

    puts "Command #{movement} received, moved to #{head_x}, #{head_y} from #{previous_position[0][0]}, #{previous_position[0][1]}"
    previous_position[0] = [head_x, head_y]

    (1..9).each do |knot|
      tail_x, tail_y = previous_position[knot][0..1]
      tail_x, tail_y = get_tail_position(previous_position[knot-1][0], previous_position[knot-1][1], tail_x, tail_y)[0..1]
      puts "Tail #{knot + 1} moved from #{previous_position[knot].join(',')} to #{tail_x},#{tail_y}" if previous_position[knot] != [tail_x, tail_y]

      previous_position[knot] = [tail_x, tail_y]
      visited_positions.push([tail_x, tail_y]) if knot == 9
    end
  end
end
puts "We've visited #{visited_positions.tally.count} positions at least than once"
