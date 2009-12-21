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

begin
  require 'vlad' # But we really mean gabrielg-vlad
  require 'vlad/core'
  require 'vlad/git'
  require 'config/deploy.rb'
rescue LoadError => e
  puts "Unable to load Vlad the Deployer - #{e.message}."
end
