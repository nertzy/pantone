#!/usr/bin/env ruby

require 'json'
require 'pry'
require 'chunky_png'
require 'fileutils'
require 'csv'

IMAGE_SIZE = [32, 32]

json_data = File.read("./pantone.json")
data = JSON.parse(json_data)
colors = data["data"]["getBook"]["colors"]

FileUtils.rm_rf("out")
FileUtils.mkdir_p("out/images")

CSV.open("out/data.csv", "wb") do |csv|
  csv << ["Filename", "Code", "Name"]
  colors.each do |color|
    filename = "#{color["positionInBook"]}.png"
    code = color["code"]
    name = color["name"]

    csv << [filename, code, name]

    rgb = color["rgb"]
    png = ChunkyPNG::Image.new(*IMAGE_SIZE, ChunkyPNG::Color.rgb(rgb["r"], rgb["g"], rgb["b"]))
    png.save("out/images/#{filename}", :interlace => true)
  end
end