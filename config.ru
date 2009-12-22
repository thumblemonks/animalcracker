ENV['RACK_ENV'] ||= "development"

$:.concat(["lib"])
require 'rubygems'
require 'caress'

require 'yaml'

env = ENV['RACK_ENV'].to_s
Caress::AssetHost.configure(YAML.load_file("config/config.yml")[env])

use Rack::ShowExceptions
use Rack::CommonLogger, File.new("#{File.dirname(__FILE__)}/log/#{env}.log", 'a+')

use Caress::App
run Sinatra::Base
