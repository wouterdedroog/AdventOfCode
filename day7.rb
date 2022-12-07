lines = File.open('inputs/day7.txt').readlines.map(&:chomp)

directory_structure = {}
current_directory = []
lines.each.with_index do |line, index|
  if line.start_with? '$ cd '
    target_directory = line.gsub! '$ cd ', ''
    case target_directory
    when '..'
      current_directory.pop
    when '/'
      current_directory = []
    else
      current_directory.append(target_directory)
    end
  elsif line.start_with? '$ ls'
    # get all lines from this to next line containing $
    directory_entry = directory_structure
    current_directory.each { |entry| (directory_entry = directory_entry[entry.to_s] ||= {}) }
    lines[index + 1..lines.size].each do |ls_line|
      break if ls_line.start_with? '$'

      directory_entry[ls_line.split(' ')[1]] = ls_line.split(' ')[0].to_i unless ls_line.start_with? 'dir'
    end
  end
end
# </parsing>
# <solution>

def get_file_size_for_directory(directory_obj)
  directory_obj.map { |file_or_directory|
    file_or_directory[1].is_a?(Integer) ? file_or_directory[1] : get_file_size_for_directory(file_or_directory[1])
  }.sum
end

def get_directories(directory_structure)
  directory_structure.reject { |_, size_or_directory| size_or_directory.is_a? Integer }
end

$directories = {}

def loop_directories(directory, name_prefix = nil)
  get_directories(directory).each do |key, directory|
    directory_name = name_prefix.nil? ? key : name_prefix + '.' + key
    directory_size = get_file_size_for_directory(directory)

    $directories[directory_name] = directory_size

    loop_directories(directory, directory_name)
  end
end

loop_directories(directory_structure)
sum_of_directories = $directories.reject { |_, sum| sum > 100_000 }.values.sum
necessary_space = get_file_size_for_directory(directory_structure) - 40_000_000
smallest_directory = $directories.sort_by { |_, value| value }.to_h.filter { |_, value| value > necessary_space }.first

puts "pt1: The total sum of directories with a size of 100.000 is #{sum_of_directories}"
puts "pt2: We need to free up #{necessary_space}, the smallest directory that would suffice would be #{smallest_directory}"

