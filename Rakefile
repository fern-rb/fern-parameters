require 'bundler/gem_tasks'
require 'rake/testtask'
require 'fern/params/version'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task :build do
  `gem build fern-params.gemspec`
end

task release: :build do
  `gem push fern-api-#{Fern::Params::VERSION}`
end

task default: :test
