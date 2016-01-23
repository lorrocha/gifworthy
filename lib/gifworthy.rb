class GifWorthy
  def initialize(directory)
    directory ||= '.'

    @input = check_directory(directory)
  end

  def check_directory(directory)
    if File.directory?(directory)
      directory
    else
      raise PathnameError, "Directory supplied is not valid: try again with another"
    end
  end
end

class PathnameError < RuntimeError
end
