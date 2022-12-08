lines = File.open('inputs/day8.txt').readlines.map(&:chomp)

def get_relevant_lines(lines, x, y)
  [
    lines[y][0..x - 1].reverse, # reverse line for easy looping in pt2
    lines[y][x + 1..-1],
    lines.map { |line| line[x] }.join[0..y - 1].reverse, # reverse line for easy looping in pt2
    lines.map { |line| line[x] }.join[y + 1..-1]
  ]
end

def tree_visible?(lines, x, y)
  get_relevant_lines(lines, x, y).map { |line| line.chars.map(&:to_i) }
                                 .filter { |line| line.filter { |tree| tree >= lines[y][x].to_i }.count.zero? }
                                 .count >= 1
end

def get_scenic_score(lines, x, y)
  get_relevant_lines(lines, x, y).map { |line| line.chars.map(&:to_i) }
                                 .map { |line| line[0..line.index { |tree| tree >= lines[y][x].to_i } || 9999] }
                                 .map(&:size).reject(&:zero?).inject(:*)
end

visible_trees = 0
scenic_scores = []
lines.each_with_index do |line, y|
  next if y.zero? || y + 1 == lines.size # skip borders

  line.chars.each_index do |x|
    next if x.zero? || x + 1 == line.length # skip borders

    visible_trees += 1 if tree_visible?(lines, x, y)
    scenic_scores.push(get_scenic_score(lines, x, y))
  end
end

p visible_trees + (lines[0].length * 2) + (lines.size * 2 - 4)
p scenic_scores.max
