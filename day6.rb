require 'set'

grid = File.open('inputs/day6.txt').readlines
           .map { |line| line.chomp.split('') }

direction = [0, -1].freeze # move up (meaning don't modify X, subtract 1 from Y every move)
current_position = grid.filter_map
                     .with_index { |line, index| [line.find_index('^'), index] if line.include? '^' }
                     .first
                     .freeze

def move(grid, current_position, direction)
  new_x = current_position[0] + direction[0]
  new_y = current_position[1] + direction[1]

  return nil if new_x.negative? or new_x >= grid[0].length
  return nil if new_y.negative? or new_y >= grid.length

  [new_x, new_y]
end

def char_at(grid, position)
  grid[position[1]][position[0]]
end

def next_direction(current_direction)
  case [current_direction[0], current_direction[1]]
  when [0, -1] then [1, 0] # up to right
  when [1, 0] then [0, 1] # right to down
  when [0, 1] then [-1, 0] # down to left
  else [0, -1] # left to up
  end
end

visited_positions = Set.new
visited_positions.add(current_position)
while true do
  old_position = current_position.clone
  current_position = move(grid, current_position, direction)
  break if current_position.nil?

  char_at_position = char_at(grid, current_position)

  if char_at_position == '#'
    direction = next_direction(direction)
    current_position = move(grid, old_position, direction)
  end

  visited_positions << current_position
end

puts "Arrived after #{visited_positions.uniq.length} movements"