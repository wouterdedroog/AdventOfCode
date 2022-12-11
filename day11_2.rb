lines = File.open('inputs/day11.txt').readlines.map(&:chomp)

monkeys = {}
monkeys_inspections_count = {} # k: monkey number v: times monkey did an inspection

def do_operation(operation, worry_level)
  left,operator,right = operation.gsub('old', worry_level.to_s).match(%r{([0-9]+) ([+*/-]) ([0-9]+)})[1..3]
  left.to_i.send(operator, right.to_i)
end

def evaluate_test(monkey, worry_level, lcm)
  worry_level = (do_operation(monkey['operation'], worry_level) % lcm).floor
  test_result = (worry_level % monkey['test']).zero?
  target_monkey = test_result ? monkey['if_true'] : monkey['if_false']

  [target_monkey, worry_level]
end

lines.each_slice(7) do |monkey|
  monkey_number = monkey[0].match(/Monkey (\d):/)[1].to_i

  monkeys[monkey_number] = {
    'items' => monkey[1].match(/\s+Starting items: ([\d, ]+)*/)[1].split(', ').map(&:to_i),
    'operation' => monkey[2].match(%r{\s+Operation: new = ([a-z]+ [+*/-] [a-z0-9]+)})[1],
    'test' => monkey[3].match(/\s+Test: divisible by (\d+)/)[1].to_i,
    'if_true' => monkey[4].match(/\s+If true: throw to monkey (\d)/)[1].to_i,
    'if_false' => monkey[5].match(/\s+If false: throw to monkey (\d)/)[1].to_i
  }
end

lcm = monkeys.map { |_, monkey| monkey['test'] }.flatten(1).reduce(&:lcm)
10_000.times do
  monkeys.each do |monkey_number, monkey|
    monkey['items'].each do |worry_level|
      target_monkey, new_worry_level = evaluate_test(monkey, worry_level, lcm)
      monkeys[target_monkey]['items'].push(new_worry_level)

      if monkeys_inspections_count.key?(monkey_number)
        monkeys_inspections_count[monkey_number] += 1
      else
        monkeys_inspections_count[monkey_number] = 1
      end
    end
    monkey['items'] = [] # will always be empty after evaluating
  end
end
p monkeys_inspections_count.sort_by { |_, inspection_count| inspection_count }.to_h.values.last(2).inject(:*)
