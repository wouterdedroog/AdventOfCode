LINES = File.open('inputs/day9.txt').readlines.map(&:chomp)

def should_move_tail(head_x, head_y, tail_x, tail_y)
  (head_x - tail_x).abs > 1 || (head_y - tail_y).abs > 1
end

def get_tail_position(head_x, head_y, tail_x, tail_y)
  return [tail_x, tail_y] unless should_move_tail(head_x, head_y, tail_x, tail_y)

  diff_x = head_x - tail_x
  diff_y = head_y - tail_y

  tail_x += diff_x.positive? ? 1 : -1 if diff_x.abs >= 1
  tail_y += diff_y.positive? ? 1 : -1 if diff_y.abs >= 1

  [tail_x, tail_y]
end

def move(head_x, head_y, movement)
  head_y += 1 if movement == 'U'
  head_y -= 1 if movement == 'D'
  head_x += 1 if movement == 'R'
  head_x -= 1 if movement == 'L'

  [head_x, head_y]
end

def solve(number_of_tails)
  visited_positions = []
  previous_position = []

  LINES.map { |line| line.split(' ')[0..1] }.each do |line|
    movement = line[0]
    steps = line[1].to_i

    head_x, head_y = (previous_position[0] ||= [0, 0])[0..1]

    steps.times do
      head_x, head_y = move(head_x, head_y, movement)

      previous_position[0] = [head_x, head_y]

      (1..number_of_tails).each do |knot|
        tail_x, tail_y = (previous_position[knot] ||= [0, 0])[0..1]
        previous_tail_x, previous_tail_y = previous_position[knot - 1][0..1]
        tail_x, tail_y = get_tail_position(previous_tail_x, previous_tail_y, tail_x, tail_y)[0..1]

        previous_position[knot] = [tail_x, tail_y]
        visited_positions.push([tail_x, tail_y]) if knot == number_of_tails
      end
    end
  end

  visited_positions.tally.count
end

puts "1 tail: we've visited #{solve(1)} positions at least than once"
puts "9 tails: we've visited #{solve(9)} positions at least than once"

