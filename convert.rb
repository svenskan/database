#!/usr/bin/env ruby

require 'nokogiri'

raise 'an HTML file is required' if ARGV.length < 1

page = Nokogiri::HTML(open(ARGV[0]))
