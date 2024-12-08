grid = File.open('inputs/day8.txt').readlines
           .map { |l| l.chomp.split('') }

chars = Hash.new { |hash, key| hash[key] = [] }
grid.each_with_index do |grid_line, y_index|
  grid_line.each_with_index do |grid_char, x_index|
    chars[grid_char] << { x: x_index, y: y_index } unless grid_char == '.'
  end
end

def distance(position, other_position)
  { x: position[:x] - other_position[:x], y: position[:y] - other_position[:y] }
end

def double_distance(distance)
  if distance.include? :original_x
    return {
      x: distance[:x] + distance[:original_x],
      y: distance[:y] + distance[:original_y],
      original_x: distance[:original_x],
      original_y: distance[:original_y]
    }
  end
  { x: distance[:x] * 2, y: distance[:y] * 2, original_x: distance[:x], original_y: distance[:y] }
end

def place_anti_nodes(grid, position, distance)
  y_coordinate = position[:y] - distance[:y]
  x_coordinate = position[:x] - distance[:x]
  return nil if y_coordinate >= grid.length or y_coordinate < 0
  return nil if x_coordinate >= grid[0].length or x_coordinate < 0

  grid[y_coordinate][x_coordinate] = '#'
  place_anti_nodes(grid, position, double_distance(distance))
end

chars.each do |_, positions|
  positions.each do |position|
    positions.filter { |other_position| other_position != position }
               .map { |other_position| { p: other_position, d: distance(position, other_position) } }
               .each { |other_position| place_anti_nodes(grid, other_position[:p], other_position[:d]) }
               .each { |other_position| grid[other_position[:p][:y]][other_position[:p][:x]] = '#' }
  end
end

puts grid.map(&:join).join("\n").count('#')