Gem::Specification.new do |s|
  s.name        = 'strict_options'
  s.version     = '0.2.0'
  s.date        = '2016-03-05'
  s.summary     = "Strict for options hash"
  s.description = "Define strict attributes for options hash"
  s.authors     = ["Volodya Sveredyuk"]
  s.email       = 'sveredyuk@gmail.com'
  s.files       = ["lib/strict_options.rb", "README.md"]
  s.homepage    = 'https://github.com/sveredyuk/strict_options'
  s.license     = 'MIT'

  # Dev gems
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'pry-rails', '~> 0'
end
