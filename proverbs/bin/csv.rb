#!/usr/bin/env ruby

require 'csv'
require 'json'

raise 'a JSON file is required' if ARGV.length < 1
raise 'an output directory is required' if ARGV.length < 2

database = JSON::load(open(ARGV[0]))
output = ARGV[1]

[('A'...'Z').to_a, 'Å', 'Ä', 'Ö'].flatten.each do |letter|
  records = database[letter]
  next if records.nil?
  CSV.open(File.join(output, "#{letter}.csv"), 'wb') do |file|
    records.map do |record|
      file << [record['expression'], record['translation'], record['meaning']]
    end
  end
end
