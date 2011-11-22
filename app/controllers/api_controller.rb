require 'RMagick'
require 'fileutils'

class ApiController < ApplicationController
  include ImageProcessor
  include Magick

  def textart
    opts = {}
    opts[:text] = params[:t]
    opts[:font] = params[:f]
    opts[:font_size] = params[:fs]
    opts[:style] = params[:s] if params[:s]
    opts[:italic] = params[:i] if params[:i]
    opts[:effect] = params[:e] if params[:e]
    opts[:rotate] = params[:r] if params[:r]
    opts[:color] = params[:c] if params[:c]
    opts[:outline_color] = params[:oc] if params[:oc]
    opts[:arc_angle] = params[:a] if params[:a]
    opts[:outline_weight] = params[:l] if params[:l]
    #opts[:distortion] = params[:d].to_f if params[:d]

    output = get_working_image(@session_id)
    ImageProcessor.generate_text(output, opts) unless File.exist?(output) 
    img = Magick::Image.read(output).first
    send_data img.to_blob, :disposition => 'inline', :type => 'image/png'
  end

  # copy the source image to working directory with unique id
  # only manipulate on the cloned source image
  def clipart
    output = get_working_image(@session_id)
    unless File.exist?(output)
      FileUtils.cp("#{Rails.root}/public/#{params[:src]}", output)
      img = Image.read(output).first
      img = img.scale(params[:rs].to_f) unless params[:rs].blank?
      img = img.level_colors(params[:b] || "", params[:w] || "", true) if params[:b] || params[:w]
      img.background_color = "none"
      img.rotate!(params[:r].to_f) unless params[:r].blank?

      #For embroidery
      if params[:emb] == 'true'
        img = img.ordered_dither
      end
      #FLIP/FLOP/Transpose/Transverse
      if params[:ff] == 'flip'
        img.flip!
      elsif params[:ff] == 'flop'
          img.flop!
      elsif params[:ff] == 'transpose'
          img.transpose!
      elsif params[:ff] == 'transverse'
          img.transverse!
      end
      #Extracts a channel
      if params[:ec] == 'R'
        img = img.channel(Magick::RedChannel)
      elsif params[:ec] == 'G'
        img = img.channel(Magick::GreenChannel)
      elsif params[:ec] == 'B'
        img = img.channel(Magick::BlueChannel)
      end

      #Applies a special effect to the image - QuantumRange
      img = img.sepiatone(Magick::QuantumRange * params[:qr].to_f) unless params[:qr].blank?

      #Vignette (Shape Edge)
      if params[:vig] == 'true'
        img = img.vignette
      end

      #Wet Floor
      if params[:wf]
        img = img.wet_floor
      end
      img.write(output)
    end
    img = Image.read(output).first
    send_data img.to_blob, :disposition => 'inline', :type => 'image/png'
  end

  #convert a design to an image
  def design2image

    bkgImg = Image.read("#{Rails.root}/public/#{params[:bkg]}").first

    sideTop = 36
    sideLeft = 95
    sideWidth = 216
    sideHeight = 353

    side = params[:side]
    if side == 'SLEEVE'
      sideWidth = 162
      sideHeight = 250
    end
    #ART Processing
    arts = params[:art];
    art_tops =  params[:art_top];
    art_lefts = params[:art_left];
    
    
    #Image.new(columns, rows)  ~ (width, height)
    containSide = Magick::Image.new(sideWidth, sideHeight) do
          self.background_color = 'none'
    end

    i=0
    if arts
      clipArt = Image.read("#{Rails.root}/public/#{arts[0]}").first
      clipArtTop = art_tops[i].to_i if art_tops[i]
      clipArtLeft = art_lefts[i].to_i if art_lefts[i]
      containSide = containSide.composite(clipArt, clipArtLeft, clipArtTop, OverCompositeOp)
    end

    #TEXT Processing
    texts = params[:text];
    text_tops =  params[:text_top];
    text_lefts = params[:text_left];


    if texts
      textArtTop = text_tops[i].to_i if text_tops[i]
      textArtLeft = text_lefts[i].to_i if text_lefts[i]
      gc = Magick::Draw.new
      textArt = Magick::Image.new(300, 200) do
            self.background_color = 'none'
      end
      gc.annotate(textArt, 0, 0, 0, 0, texts[i]) do
            self.gravity = Magick::NorthWestGravity
            self.pointsize = 22
            self.font_family = "Times"
            self.fill = '#0000A9'
            self.stroke = "none"
      end
    end

    containSide.composite!(textArt, textArtLeft || 0, textArtTop || 0, OverCompositeOp) if textArt
    
    bkgImg.composite!(containSide, sideLeft, sideTop, OverCompositeOp)
    bkgImg.scale!(0.5)

    send_data bkgImg.to_blob, :disposition => 'inline', :type => 'image/png'

#    output = get_working_image(@session_id)
#    unless File.exist?(output)
#      FileUtils.cp("#{RAILS_ROOT}/public/images/#{params[:textart]}.png", output)
#      img = Image.read(output).first
#      img = img.scale(params[:rs].to_f) unless params[:rs].blank?
#      img = img.level_colors(params[:b] || "", params[:w] || "", true) if params[:b] || params[:w]
#      img.background_color = "none"
#      img = img.rotate(params[:r].to_f) unless params[:r].blank?
#      img.write(output)
#    end
#    img = Image.read(output).first
#    send_data img.to_blob, :disposition => 'inline', :type => 'image/png'

  end

  private

  # return the working image based on the session id and request params
  def get_working_image(session_id)
    working_dir = "#{Rails.root}/dsg/#{session_id}"
    FileUtils.mkdir_p(working_dir) unless File.exist?(working_dir)
    uid = to_uid(CGI::unescape(request.query_string))
    output = "#{working_dir}/#{uid}.png"
  end

  def to_uid(s)
    s.gsub(/&/, "").gsub(/\s/, "").gsub(/=/, "").gsub(/-/, "").gsub(/_/, "").gsub(/\//, "").downcase
  end
end
