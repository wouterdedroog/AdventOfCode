require 'set'

grid = File.open('inputs/day6.txt').readlines
           .map { |line| line.chomp.split('') }

start_direction = [0, -1].freeze # move up (meaning don't modify X, subtract 1 from Y every move)
start_position = grid.filter_map
                     .with_index { |line, index| [line.find_index('^'), index, start_direction] if line.include? '^' }
                     .first
                     .freeze

possible_grids = []
grid.each.with_index do |y_line, y_index|
  y_line.each.with_index do |x_char, x_index|
    next unless x_char == '.'
    new_grid = grid.map(&:clone)
    new_grid[y_index][x_index] = '#'
    possible_grids << new_grid if new_grid != grid
  end
end

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

maps = possible_grids.map.with_index do |possible_grid, index|
  visited_positions = Set.new
  visited_positions.add(start_position)

  direction = start_direction.clone
  current_position = start_position
  is_loop = while true do
              current_position = move(possible_grid, current_position, direction)
              break false if current_position.nil?
              break true if is_in_loop(current_position, visited_positions)

              char_at_position = char_at(possible_grid, current_position)

              if char_at_position == '#'
                back_direction = next_direction(next_direction(direction))
                current_position = move(possible_grid, current_position, back_direction)

                direction = next_direction(direction)
                move(possible_grid, current_position, back_direction)
              end

              visited_positions.add(current_position)
            end
  p "yippieee #{index}" if is_loop
  puts "Checked #{index} / #{possible_grids.count}"
  is_loop
end
p maps.filter { |x| x }.count