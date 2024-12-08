grid = File.open('inputs/day8.txt').readlines
            .map { |l| l.chomp.split('') }

chars = Hash.new { |hash, key| hash[key] = [] }
grid.each_with_index do |grid_line, y_index|
  grid_line.each_with_index do |grid_char, x_index|
    chars[grid_char] << {x: x_index, y: y_index} unless grid_char == '.'
  end
end

def distance(position, other_position)
    {x: position[:x] - other_position[:x], y: position[:y] - other_position[:y]}
end

def place_anti_nodes(grid, position, distance)
    y_coordinate = position[:y] - distance[:y]
    x_coordinate = position[:x] - distance[:x]
    return if y_coordinate >= grid.length or y_coordinate < 0
    return if x_coordinate >= grid[0].length or x_coordinate < 0

    grid[y_coordinate][x_coordinate] = '#'
end

chars.each do |_, positions|
  positions.each do |position|
    positions.filter { |other_position| other_position != position }
             .map { |other_position| { p: other_position, d: distance(position, other_position) } }
             .each { |other_position| place_anti_nodes(grid, other_position[:p], other_position[:d])}
  end
end

puts grid.map(&:join).join("\n").count('#')