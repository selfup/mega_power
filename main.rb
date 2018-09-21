require 'pry'

require 'csv'
require 'colorize'

MEGA_DATA = './mega/data.csv'
POWER_DATA = './power/data.csv'

@mega_rows = []
@power_rows = []

def load(file, data_array)
  CSV.foreach(file, :headers => true) do |row|
    data_array << row.to_hash
  end
end

def load_all
  if !File.file?(MEGA_DATA) && !File.file?(POWER_DATA)
    puts "MEGA MILLIONS OR POWERBALL DATA DOES NOT EXIST".colorize(:red)
    puts "PLEASE RUN: ruby main.rb new".colorize(:yellow)
    puts "THEN RUN: ruby main.rb recent".colorize(:cyan)

    exit
  end

  load(MEGA_DATA, @mega_rows)
  load(POWER_DATA, @power_rows)
end

if ARGV[0] == 'new'
  puts 'Pulling in new data'.colorize(:cyan)

  puts `./scripts/mega.sh`
  puts `./scripts/power.sh`

  load_all
elsif ARGV[0] == 'recent'
  load_all

  puts "MEGA MILLIONS\n".colorize(:red)
  puts @mega_rows[-8..-1]

  puts "\n---------------\n".colorize(:yellow)

  puts "POWERBALL\n".colorize(:blue)
  puts @power_rows[-8..-1]
else
  puts 'Wrong argument'.colorize(:red)
end
