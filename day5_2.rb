lines = File.open('inputs/day5.txt').readlines
header_lines = lines.select { |l| l.include? '[' }
                    .map { |line| line.chars.select.with_index { |_, i| ((i - 1) % 4).zero? } }
rows = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [] }

header_lines.reverse.each_with_index do |line, index|
  line.each_with_index do |letter, letter_index|
    rows[letter_index + 1].append(letter) unless letter == ' '
  end
end
# </parsing>
# <solution>
lines = lines.select { |line| line.include? 'move' }
             .map { |line| line.match(/move (\d{1,2}) from (\d) to (\d)/) }

lines.each do |match_data|
  amount, from, to = match_data[1..3].map(&:to_i)

  rows[to].concat(rows[from].last(amount))
  rows[from].pop(amount)
end
puts rows.values.map(&:last).join
