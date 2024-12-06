require 'set'

grid = File.open('inputs/day6.txt').readlines
           .map { |line| line.chomp.split('') }

start_direction = [0, -1].freeze # move up (meaning don't modify X, subtract 1 from Y every move)
start_position = grid.filter_map
                     .with_index { |line, index|
                       [line.find_index('^'), index, start_direction] if line.include? '^'
                     }.first.freeze

def move(grid, current_position, direction)
  new_x = current_position[0] + direction[0]
  new_y = current_position[1] + direction[1]

  return nil if new_x.negative? or new_x >= grid[0].length
  return nil if new_y.negative? or new_y >= grid.length

  [new_x, new_y, direction]
end

def char_at(grid, position)
  grid[position[1]][position[0]]
end

def next_direction(current_direction)
  case [current_direction[0], current_direction[1]]
  when [0, -1] then [1, 0] # up to right
  when [1, 0] then [0, 1] # right to down
  when [0, 1] then [-1, 0] # down to left
  when [-1, 0] then [0, -1] # left to up
  end
end

def is_in_loop(current_position, visited_positions)
  visited_positions.include? current_position
end

def solve_grid(grid, start_position, start_direction)
  visited_positions = Set.new
  visited_positions.add(start_position)

  current_position = start_position
  direction = start_direction.clone
  while true do
    current_position = move(grid, current_position, direction)
    break if current_position.nil?
    return true if is_in_loop(current_position, visited_positions)

    char_at_position = char_at(grid, current_position)

    if char_at_position == '#'
      # move 1 step back
      back_direction = next_direction(next_direction(direction))
      current_position = move(grid, current_position, back_direction)

      direction = next_direction(direction)
    end

    visited_positions.add(current_position)
  end

  visited_positions.map { |x| [x[0], x[1]] }.uniq
end

pt1_visited_positions = solve_grid(grid, start_position, start_direction)
puts "Part 1: #{pt1_visited_positions.count}"

# Part 2
loops = grid.map.with_index do |y_line, y_index|
  y_line.each_with_index.count do |x_char, x_index|
    next unless x_char == '.'
    next unless pt1_visited_positions.include? [x_index, y_index]

    new_grid = grid.map(&:dup)
    new_grid[y_index][x_index] = '#'

    solve_grid(new_grid, start_position, start_direction).is_a? TrueClass
  end
end.sum

puts "Part 2: #{loops}"

