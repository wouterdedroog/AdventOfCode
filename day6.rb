line = File.open('inputs/day6.txt').readline

def find_start_marker(line, length)
  line.length.times do |index|
    return index + length if line[index..index + length - 1].chars.uniq.size == length
  end
end

p find_start_marker(line, 4)
p find_start_marker(line, 14)
