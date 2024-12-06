grid = File.open('inputs/day6.txt').readlines
            .map { |line| line.chomp.split('') }

current_position = grid.filter_map
                       .with_index { |line, index| {x: line.find_index('^'), y: index} if line.include? '^' }
                       .first
visited_positions = [current_position]

def move(grid, current_position, direction)
  new_x = current_position[:x] + direction[:x]
  new_y = current_position[:y] + direction[:y]

  return nil if new_x.negative? or new_x >= grid[0].length
  return nil if new_y.negative? or new_y >= grid.length

  {y: new_y, x: new_x}
end

def char_at(grid, position)
  grid[position[:y]][position[:x]]
end

def next_direction(current_direction)
  return {x: 1, y: 0} if current_direction == {x: 0, y: -1} # go from up to right
  return {x: 0, y: 1} if current_direction == {x: 1, y: 0} # go from right to down
  return {x: -1, y: 0} if current_direction == {x: 0, y: 1} # go from down to left
  return {x: 0, y: -1} if current_direction == {x: -1, y: 0} # go from left to up
end

direction = {x: 0, y: -1} # move up (meaning don't modify X, subtract 1 from Y every move)
while true do
  current_position = move(grid, current_position, direction)
  visited_positions += [current_position]

  next_position = move(grid, current_position, direction)
  break if next_position.nil?
  char_at_next_position = char_at(grid, next_position)

  puts "Moved to #{current_position}, next char is #{char_at_next_position} (visited #{visited_positions.uniq.length} spots)"
  if char_at_next_position == '#'
    direction = next_direction(direction)
    puts "Encountered a #, changing direction to #{direction}"
  end
end

puts "Arrived at #{current_position} after #{visited_positions.uniq.length} movements"