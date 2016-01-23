#!/usr/bin/env ruby

require 'csv'
require 'json'

raise 'a JSON file is required' if ARGV.length < 1
raise 'an output directory is required' if ARGV.length < 2

database = JSON::load(open(ARGV[0]))
output = ARGV[1]

[('A'...'Z').to_a, 'Å', 'Ä', 'Ö'].flatten.each do |letter|
end
