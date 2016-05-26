class GifMaker
  include Magick
  VALID_TYPES = ['png', 'jpeg', 'jpg']

  def initialize(directory, output, options)
    @directory = directory
    @output = output
    @options = options

    make_gif
  end

  def make_gif
    gif = ImageList.new

    binding.pry
    valid_entries.each do |valid_path|
      gif << Image.read(valid_path).first
    end

    if delay = @options['delay']
      gif.delay = delay
    end

    gif.write(@output + '.gif')
    puts "Gif created at: #{Dir.pwd}/#{@output}.gif"
  end

  def valid_entries
    Dir[@directory + '/*'].select { |path|
      VALID_TYPES.include? path.split('.').last.downcase
    }.sort_by { |path|
      path.match(/(?<=_)(?<num>[0-9]*)(?=\.(png|jpeg|jpg))/)['num'].to_i
    }
  end
end
