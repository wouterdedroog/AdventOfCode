lines = File.open('inputs/day4.txt').readlines
            .map { |line| line.split('') }

def c(l, x, y)
  return nil if x < 0 or y < 0
  return nil if y >= l.count
  return nil if x >= l[y].count
  l[y][x]
end

def find_xmas_from(l, x, y)
  occurrences = 0

  occurrences+=1 if c(l,x+1,y) == 'M' and c(l,x+2,y) == 'A' and c(l,x+3,y) == 'S' # LEFT TO RIGHT
  occurrences+=1 if c(l,x-1,y) == 'M' and c(l,x-2,y) == 'A' and c(l,x-3,y) == 'S' # RIGHT TO LEFT
  occurrences+=1 if c(l,x,y+1) == 'M' and c(l,x,y+2) == 'A' and c(l,x,y+3) == 'S' # UP
  occurrences+=1 if c(l,x,y-1) == 'M' and c(l,x,y-2) == 'A' and c(l,x,y-3) == 'S' # DOWN

  occurrences+=1 if c(l,x+1,y-1) == 'M' and c(l,x+2,y-2) == 'A' and c(l,x+3,y-3) == 'S' # DOWN RIGHT
  occurrences+=1 if c(l,x-1,y-1) == 'M' and c(l,x-2,y-2) == 'A' and c(l,x-3,y-3) == 'S' # DOWN LEFT
  occurrences+=1 if c(l,x+1,y+1) == 'M' and c(l,x+2,y+2) == 'A' and c(l,x+3,y+3) == 'S' # UP RIGHT
  occurrences+=1 if c(l,x-1,y+1) == 'M' and c(l,x-2,y+2) == 'A' and c(l,x-3,y+3) == 'S' # UP LEFT

  occurrences
end

def find_x_mas_from(l, x, y)
  occurrences = 0
  occurrences += 1 if c(l, x-1, y-1) == 'M' and c(l, x+1, y-1) == 'S' and c(l, x-1, y+1) == 'M' and c(l, x+1, y+1) == 'S' # m.s .a. m.s
  occurrences += 1 if c(l, x-1, y-1) == 'S' and c(l, x+1, y-1) == 'S' and c(l, x-1, y+1) == 'M' and c(l, x+1, y+1) == 'M' # s.s .a. m.m
  occurrences += 1 if c(l, x-1, y-1) == 'M' and c(l, x+1, y-1) == 'M' and c(l, x-1, y+1) == 'S' and c(l, x+1, y+1) == 'S' # m.m .a. s.s
  occurrences += 1 if c(l, x-1, y-1) == 'S' and c(l, x+1, y-1) == 'M' and c(l, x-1, y+1) == 'S' and c(l, x+1, y+1) == 'M' # s.m .a. s.m

  occurrences
end

pt1 = lines.map.with_index do |line, y_index|
    line.each_index
        .select{|i| line[i] == 'X'}
        .map { |x_index| find_xmas_from(lines, x_index, y_index) }
        .sum
end.sum
puts "Part 1: #{pt1}"

pt2 = lines.map.with_index do |line, y_index|
  line.each_index
      .select{|i| line[i] == 'A'}
      .map { |x_index| find_x_mas_from(lines, x_index, y_index) }
      .sum
end.sum
puts "Part 2: #{pt2}"
