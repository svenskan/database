#!/usr/bin/env ruby

require 'csv'
require 'json'

raise 'a JSON file is required' if ARGV.length < 1

ATTRIBUTES = %w(translation infinitiv presens preteritum supinum imperativum)

records = JSON::load(open(ARGV[0]))

CSV do |output|
  records.map do |record|
    output << ATTRIBUTES.map { |attribute| record[attribute] }
  end
end
