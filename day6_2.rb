line = File.open('inputs/day6.txt').readline

line.length.times do |index|
  if line[index..index+13].chars.uniq.size == 14
    p index + 14
    return
  end
end