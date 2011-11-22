module ImageProcessor
  class TextProcessError < StandardError;end
  class ArtProcessError < StandardError;end
  class MissingRequiredParam < StandardError;end

  def self.generate_text(output, options = {})
    raise MissingRequiredParam.new("Param 'text' is required.") unless options.has_key?(:text)
    raise MissingRequiredParam.new("Param 'font' is required.") unless options.has_key?(:font)
    raise MissingRequiredParam.new("Param 'font_size' is required.") unless options.has_key?(:font_size)

    cmd = "#{RAILS_ROOT}/imagick/texteffect "
    cmd << "-x 0 " 
    cmd << "-b none " 
    cmd << "-t '#{options[:text]}' "
    cmd << "-f #{RAILS_ROOT}/fonts/#{options[:font]}.ttf "
    cmd << "-p #{options[:font_size]} "
    cmd << "-s #{options[:style] || 'plain'} "
    cmd << "-i #{options[:italic]} " if options[:italic]
    cmd << "-e #{options[:effect] || 'normal'} " 
    cmd << "-r #{options[:rotate]} " if options[:rotate]
    cmd << "-c #{options[:color] || 'black'} "
    cmd << "-o #{options[:outline_color]} " if options[:outline_color]
    cmd << "-a #{options[:arc_angle]} " if options[:arc_angle]
    cmd << "-l #{options[:outline_weight]} " if options[:outline_weight]
    #cmd << "-d #{options[:distortion]} " if options[:distortion]
    cmd << "#{output}"
    begin
      system(cmd) # execute command
      raise unless File.exist?(output)
    rescue
      raise TextProcessError.new("Failed to generate text image.")
    end
  end  

  def self.make_one_color(source, output, options = {})

  end
end
