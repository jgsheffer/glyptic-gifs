Gem::Specification.new do |s|
  s.name        = 'glyptic_gifs'
  s.version     = '0.0.4'
  s.date        = '2016-06-27'
  s.summary     = "Gif Creating Library"
  s.description = 
  "Glyptic Gifs - A gem which assists in the creation of gifs for cucumber projects
  "
  s.authors     = ["Jared Sheffer"]
  s.email       = 'magus.chef@gmail.com'
  s.files       = ["lib/glyptic_gifs.rb"]
  s.add_runtime_dependency "rmagick",
    ["= 2.15.4"]
  s.add_runtime_dependency 'cucumber', '~> 2.0', '>= 2.0.0'
  s.homepage    =
    'http://rubygems.org/gems/glyptic_gifs'
  s.license       = 'MIT'
end