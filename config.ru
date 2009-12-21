$:.concat("..", "../lib")
require 'rubygems'
require 'caress'

use Rack::ShowExceptions
use Rack::CommonLogger, File.new("#{File.dirname(__FILE__)}/log/#{ENV['RACK_ENV']}.log", 'a+')

use Caress
run Sinatra::Base
