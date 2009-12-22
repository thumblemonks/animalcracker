require 'rubygems'
require 'rake'
require 'rake/testtask'

desc 'Default task: run all tests'
task :default => [:test]

desc "Run all tests"
Rake::TestTask.new("test") do |t|
  t.libs.concat ['./lib', './test']
  t.test_files = FileList['test/*_test.rb']
  t.verbose = false
end

#
# Some monks like diamonds. I like gems.

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "animalcracker"
    gem.summary = "A sweet Sinatra extension for asset hosting"
    gem.description = "A sweet Sinatra extension for asset hosting. Roarrrrrrrr"
    gem.email = "gus@gusg.us"
    gem.homepage = "http://github.com/thumblemonks/animalcracker"
    gem.authors = ["Justin 'Gus' Knowlden"]
    gem.add_dependency "sinatra"
    gem.add_development_dependency "riot"
    gem.add_development_dependency "chicago"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
