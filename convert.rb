#!/usr/bin/env ruby

require 'json'
require 'nokogiri'

class Proverb
  ATTRIBUTES = [:text, :translation, :meaning]

  attr_accessor *ATTRIBUTES

  def self.parse(element)
    text = element.css('i')[0]
    return nil if text.nil?

    proverb = Proverb.new
    proverb.text = text.text
    proverb
  end

  def to_s
    JSON.pretty_generate(as_json)
  end

  def as_json(options = {})
    object = {}
    ATTRIBUTES.each do |attribute|
      value = self.send(attribute)
      object[attribute] = value unless value.nil?
    end
    object
  end
end

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
    proverb = Proverb.parse(element)
    next if proverb.nil?
    puts proverb
  end
end
