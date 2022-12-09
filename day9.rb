lines = File.open('inputs/day9.txt').readlines.map(&:chomp)

visited_positions = []
previous_position = {
  H: [0, 0],
  T: [0, 0]
}

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

  head_x, head_y = previous_position[:H][0..1]
  tail_x, tail_y = previous_position[:T][0..1]

  steps.times do
    case movement
    when 'U'
      head_y += 1
    when 'D'
      head_y -= 1
    when 'R'
      head_x += 1
    when 'L'
      head_x -= 1
    end

    tail_x, tail_y = get_tail_position(head_x, head_y, tail_x, tail_y)[0..1]
    puts "Command #{movement} received, moved to #{head_x}, #{head_y} from #{previous_position[:H][0]}, #{previous_position[:H][1]}"
    puts "Tail moved from #{previous_position[:T].join(',')} to #{tail_x},#{tail_y}" if previous_position[:T] != [tail_x, tail_y]

    previous_position[:H] = [head_x, head_y]
    previous_position[:T] = [tail_x, tail_y]

    visited_positions.push(previous_position[:T])
  end
end
puts "We've visited #{visited_positions.tally.count} positions at least than once"
