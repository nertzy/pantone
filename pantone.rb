#!/usr/bin/env ruby

require 'json'
require 'pry'
require 'chunky_png'
require 'fileutils'

IMAGE_SIZE = [32, 32]

json_data = File.read("./pantone.json")
data = JSON.parse(json_data)
colors = data["data"]["getBook"]["colors"]

FileUtils.rm_rf("images")
FileUtils.mkdir_p("images")

colors.each do |color|
  filename = "#{color["positionInBook"]}.png"
  rgb = color["rgb"]
  png = ChunkyPNG::Image.new(*IMAGE_SIZE, ChunkyPNG::Color.rgb(rgb["r"], rgb["g"], rgb["b"]))
  png.save("images/#{filename}", :interlace => true)
end
