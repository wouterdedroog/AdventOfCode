lines = File.open('inputs/day5.txt').readlines
            .map {|l| l.chomp }
ordering_rules = lines.filter { |l| l.include? '|'}
                      .map { |l| l.split('|').map(&:to_i) }

updates = lines.filter { |l| !l.empty? and !l.include? '|' }
               .map { |l| l.split(',').map(&:to_i) }

def do_update(update, rules)
    update = update.clone
    rules.each do |page, must_be_before|
        page_index = update.find_index(page)
        must_be_before_index = update.find_index(must_be_before)
        if update.include? page and update.include? must_be_before and page_index > must_be_before_index
            update = update.insert(must_be_before_index, update.delete_at(page_index))
            return do_update(update, rules)
        end
    end

    update
end


part1 = updates.filter { |update| do_update(update, ordering_rules) == update }
               .map { |update| update[update.count / 2] }
               .sum
puts "Part 1: #{part1}"

part2 = updates.map { |update| fixed = do_update(update, ordering_rules); fixed if fixed != update }
         .compact
         .map { |update| update[update.count / 2] }
         .sum
puts "Part 2: #{part2}"
