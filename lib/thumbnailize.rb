require 'RMagick'
require 'fileutils'

module Thumbnailize
  include Magick

  def self.generate(source_dir, dest_dir)
    source = source_dir + "/*"
    Dir["#{source}"].each do |file_name|
      if File.file?(file_name)
        img = Image.read(file_name).first
        img = img.scale(0.5)
        img.write(dest_dir + File.basename(file_name))
      end
    end
  end
end

#Thumbnailize.generate("/home/hoangnghiem/Documents/projects/rails3/inkunik3/public/images/tshirts/male/*")
Thumbnailize.generate(ARGV[0], ARGV[1])
