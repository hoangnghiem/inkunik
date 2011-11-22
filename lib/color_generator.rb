require 'RMagick'
require 'fileutils'

module ColorGenerator
  include Magick

  COLOR_CODES = [
    '#c0e1ff','#7299c6','#00a5d9','#093eb6','#06294d',
    '#00ffd8','#719986','#00a185','#269c4a','#949b51',
    '#fff6dc','#d3cab7','#c8b89e','#774E39','#59582b',
    '#ffffff','#e4e5e6','#b6b8ba','#4f4b4d','#0f0f0f',
    '#ef5091','#dc1414','#820024','#53247f','#4a1f4b',
    '#f9c4ce','#f5ffbb','#fff578','#e6b329','#ef6821'
  ]
  COLOR_NAMES = [
    'Light Blue','Blue Jean','Turqoise','Royal Blue','Navy',
    'Mint','Sagestone','Jade','Kelly Green','Olive Green',
    'Cream','Sand','Khaki','Brown','Army Green',
    'White','Silver Grey','Heatherish','Dark Grey','Black',
    'Fuchsia','Red','Maroon','Purple','Eggplant',
    'Pink','Lemon','Banana','Gold','Orange'
  ]

  def self.generate(size, dest_dir)
    #dest_dir = "#{Rails.root}/public/images/tshirts/colors/#{dest_name}"
    FileUtils.mkdir_p dest_dir
    COLOR_CODES.each_with_index do |code, index|
      img = Image.new(size.to_i, size.to_i) { self.background_color = "#{code}"}
      img.write("#{dest_dir}/#{COLOR_NAMES[index].gsub(' ', '').downcase}.jpg")
    end
  end
end
ColorGenerator.generate(ARGV[0], ARGV[1])
