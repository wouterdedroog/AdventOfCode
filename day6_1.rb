line = File.open('inputs/day6.txt').readline

line.length.times do |index|
  if line[index..index+3].chars.uniq.size == 4
    p index + 4
    return
  end
end