#!/usr/bin/env crun
require "json"
require "xml"

xml = File.read ARGV[0]

node = XML.parse xml
svg = node.first_element_child

result = JSON.build do |json|
  json.object do
    if svg.nil?
    else
      svg.children.select(&.element?).each do |child|
        json.field child["id"] { json.string child["fill"] }
      end
    end
  end
end

puts result
