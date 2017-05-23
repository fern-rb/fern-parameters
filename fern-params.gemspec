lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fern/params/version'

Gem::Specification.new do |s|
  s.name        = 'fern-params'
  s.version     = Fern::Params::VERSION
  s.date        = '2017-03-11'
  s.authors     = ['Kyle Kestell']
  s.email       = 'kyle@kestell.org'
  s.summary     = 'Fern Params'
  s.description = 'Typed parameters for Fern.'
  s.homepage    = 'https://github.com/kkestell/fern-params'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*']

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'fern-api', '~> 0'

  s.add_development_dependency 'fern-api', '~> 0'
  s.add_development_dependency 'bundler', '~> 1.15'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'minitest', '~> 5.0'
end
