#!/usr/bin/env ruby

require 'json'
require 'nokogiri'

class Record
  ATTRIBUTES = %i(translation infinitiv presens preteritum supinum imperativum)

  attr_accessor *ATTRIBUTES

  def initialize(element)
    attributes = element.css('td')
    raise 'expected six columns' unless attributes.length == 6
    ATTRIBUTES.each_with_index do |attribute, i|
      self.send("#{attribute}=", typography(attributes[i].text))
    end
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

def typography(text)
  text.gsub!('!', '')
  text
end

raise 'an HTML file is required' if ARGV.length < 1

page = Nokogiri::HTML(open(ARGV[0]))
elements = page.css('#mw-content-text tr')
elements.shift

database = []
elements.each do |element|
  database << Record.new(element)
end

puts JSON.pretty_generate(database)
