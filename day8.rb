lines = File.open('inputs/day8.txt').readlines.map(&:chomp)

grid = []

lines.each do |line|
  grid.push(line)
end

def get_relevant_lines(grid, x, y)
  [
    grid[y][0..x - 1].reverse, # reverse line for pt2
    grid[y][x + 1..-1],
    grid.map { |line| line[x] }.join[0..y - 1].reverse, # reverse line for pt2
    grid.map { |line| line[x] }.join[y + 1..-1]
  ]
end

def tree_visible?(grid, height, x, y)
  get_relevant_lines(grid, x, y).map {  |line| line.chars.map(&:to_i) }
                                .filter { |line| line.filter { |tree| tree >= height }.count.zero? }
                                .count >= 1
end

def get_scenic_score(grid, height, x, y)
  get_relevant_lines(grid, x, y).map { |line| line.chars.map(&:to_i) }
                                .map { |line| line[0..line.index { |tree| tree >= height } || 9999] }
                                .map(&:size).reject(&:zero?).inject(:*)
end

visible_trees = 0
scenic_scores = []
grid.each_with_index do |line, y|
  next if y.zero? || y + 1 == lines.size # skip borders

  line.chars.each_with_index do |height, x|
    next if x.zero? || x + 1 == line.length # skip borders

    visible_trees += 1 if tree_visible?(grid, height.to_i, x, y)
    scenic_scores.push(get_scenic_score(grid, height.to_i, x, y))
  end
end

p visible_trees + (lines[0].length * 2) + (lines.size * 2 - 4)
p scenic_scores.max
