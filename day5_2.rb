lines = File.open('inputs/day5.txt').readlines
header_lines = lines.select { |l| l.include? '[' }
                    .map { |line| line.chars.select.with_index { |_, i| ((i - 1) % 4).zero? } }
rows = {1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => []}

header_lines.reverse.each_with_index do |line, index|
  line.each_with_index do |letter, letter_index|
    rows[letter_index + 1].append(letter) unless letter == ' '
  end
end

lines = lines.select { |line| line.include? 'move' }
             .map { |line| line.match(/move (\d{1,2}) from (\d) to (\d)/) }

lines.each do |match_data|
  amount = match_data[1].to_i
  from = match_data[2].to_i
  to = match_data[3].to_i

  rows[to].concat(rows[from].last(amount))
  rows[from].pop(amount)
end
puts rows.keys.map { |key| rows[key][rows[key].length - 1] }.join
