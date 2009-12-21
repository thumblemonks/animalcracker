require 'asset_host'
require 'sinatra'

class CaressApp < Sinatra::Base
  # set :public, File.join(File.dirname(__FILE__), '..', 'public')
  enable :logging, :dump_errors #, :static

end
