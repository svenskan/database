#!/usr/bin/env ruby

require 'nokogiri'

raise 'an HTML file is required' if ARGV.length < 1

page = Nokogiri::HTML(open(ARGV[0]))
elements = page.css('#mw-content-text')[0].children

letter = nil
elements.each do |element|
  case element.node_name
  when 'h2'
    letter = element.css('.mw-headline').text
    next unless letter.length == 1
    puts "Letter: #{letter}"
  when 'ul'
    text = element.css('i')[0]
    next if text.nil?
    text = text.text
    puts "Pronoun: #{text}"
  end
end
