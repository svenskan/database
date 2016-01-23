#!/usr/bin/env ruby

require 'json'
require 'nokogiri'

class Proverb
  ATTRIBUTES = [:expression, :equivalent, :translation, :meaning]

  attr_accessor *ATTRIBUTES

  def self.parse(element)
    attribute = element.css('i')[0]
    return nil if attribute.nil?

    proverb = Proverb.new
    proverb.expression = attribute.text

    element.css('li').each do |attribute|
      text = attribute.text
      case text
      when /^Translation and English equivalent: (.*)$/i, /^English equivalent: (.*)$/i
        proverb.equivalent = typograph($1)
      when /^Translation: (.*)$/i
        proverb.translation = typograph($1)
      when  /^Meaning: "(.*)"\.$/i, /^Meaning: "(.*)"$/i, /^Meaning: (.*)$/i
        proverb.meaning = typograph($1)
      end
    end

    proverb
  end

  def to_json(options = {})
    as_json.to_json(options)
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

def typograph(text)
  text.gsub!(/ '/, ' ‘')
  text.gsub!(/^'/, '‘')
  text.gsub!(/'/, '’')
  text.gsub!(/ — /, '—')
  text.gsub!(/ – /, '—')
  text
end

raise 'an HTML file is required' if ARGV.length < 1

page = Nokogiri::HTML(open(ARGV[0]))
elements = page.css('#mw-content-text')[0].children

database = {}
letter = nil
elements.each do |element|
  case element.node_name
  when 'h2'
    letter = element.css('.mw-headline').text
    next unless letter.length == 1
    database[letter] = []
  when 'ul'
    proverb = Proverb.parse(element)
    next if proverb.nil?
    database[letter] << proverb
  end
end

puts JSON.pretty_generate(database)
