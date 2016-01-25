require 'rmagick'

class GifWorthy
  VALID_ARGUMENTS = {'-d' => 'delay'}

  def initialize(arguments)
    directory, output, options = sanatize_options(arguments)

    input = check_directory(directory) until input
    output ||= Time.now.strftime("%F-%H%M%S")

    puts "Synthesizing gif #{output} from directory #{input}..."
    GifMaker.new(input, output, options)
  end

  def sanatize_options(arguments)
    options = {}

    VALID_ARGUMENTS.each do |flag, key|
      if arguments.include?(flag)
        flag_index = arguments.index(flag)
        flag_value = arguments[flag_index + 1]

        options[key] = flag_value

        arguments.delete_at(flag_index + 1)
        arguments.delete_at(flag_index)
      end
    end

    [arguments[0], arguments[1], options]
  end

  def check_directory(directory)
    if File.directory?(directory)
      directory
    else
      raise PathnameError, "Directory supplied is not valid: try again with another. If you need additional help, try `gifworthy help`"
    end
  end
end

class GifMaker
  include Magick
  VALID_TYPES = ['png', 'jpeg']

  def initialize(directory, output, options)
    @directory = directory
    @output = output
    @options = options

    make_gif
  end

  def make_gif
    gif = ImageList.new

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
      path.match(/(?<=_)(?<num>[0-9]*)(?=.png|.jpeg)/)['num'].to_i
    }
  end
end

class PathnameError < RuntimeError
end
