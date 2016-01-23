Gem::Specification.new do |s|
  s.name        = 'gifworthy'
  s.version     = '0.0.0'
  s.date        = '2016-01-22'
  s.summary     = "Command line tool for making gifs out of a folder of images."
  s.description = "A simple command line tool for making gifs out of a folder of images."
  s.authors     = ["Lorrayne Rocha"]
  s.email       = 'lorrocha90@gmail.com'
  s.files       = ["lib/gifworthy.rb"]
  s.homepage    = 'http://rubygems.org/gems/gifworthy'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rmagick', '~> 2.15'
  s.executables << 'gifworthy'
end
