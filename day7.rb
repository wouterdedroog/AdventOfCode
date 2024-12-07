lines = File.open('inputs/day7.txt').readlines
            .map { |l| { :outcome => l.split(':')[0].to_i, :numbers => l.split(':')[1].split(' ').map(&:to_i) } }

def all_options(operators, numbers)
    operators.repeated_permutation(numbers.count - 1).to_a
end

def evaluate_left_to_right(numbers, option)
    last = numbers[0]
    ((0..numbers.count - 2).map do |index|
        if option[index] == '+'
            outcome = last + numbers[index+1]
        elsif option[index] == '*'
            outcome = last * numbers[index+1]
        else # ||
            outcome = (last.to_s + numbers[index+1].to_s).to_i
        end

        last = outcome
        outcome
    end).last
end

def is_solvable(line, operators)
    outcome = line[:outcome]
    numbers = line[:numbers]

    all_options(operators, numbers).any? { |option| evaluate_left_to_right(numbers, option) == outcome } ? outcome : 0
end

operators = %w[+ *]
puts "Part 1: #{lines.compact.sum { |line| is_solvable(line, operators) }}"

operators = %w[+ * ||]
puts "Part 2: #{lines.compact.sum { |line| is_solvable(line, operators) }}"
