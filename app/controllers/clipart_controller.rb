require 'rubygems'
require 'RMagick'
class ClipartController < ApplicationController
  include Magick

  def manipulate
    text = Magick::Draw.new
    text.font_family = 'helvetica'
    text.pointsize = 52
    metric = text.get_type_metrics("RMagick")
    img = Image.new(metric.width,metric.height)
    img.format = "gif"
    text.annotate(img,0,0,-2,metric.height - 15, "RMagick") {
      self.fill = 'darkred'
    }
    img = img.transparent('white').re;
    send_data img.to_blob, :disposition => 'inline', :type => 'image/gif'
  end
end
