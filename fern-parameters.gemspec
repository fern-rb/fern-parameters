lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fern/parameters/version'

Gem::Specification.new do |s|
  s.name        = 'fern-parameters'
  s.version     = Fern::Parameters::VERSION
  s.date        = '2017-03-11'
  s.authors     = ['Kyle Kestell']
  s.email       = 'kyle@kestell.org'
  s.summary     = 'Fern Parameters'
  s.description = 'Typed parameters for Fern.'
  s.homepage    = 'https://github.com/kkestell/fern-parameters'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*']

  s.required_ruby_version = '>= 2.1.0'

  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'fern-api', '~> 0'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rake', '~> 10.0'

  s.add_runtime_dependency 'actionpack', '~> 5.0'
  s.add_runtime_dependency 'activesupport', '~> 5.0'
  s.add_runtime_dependency 'fern-api', '~> 0'
end