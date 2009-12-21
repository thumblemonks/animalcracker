require 'asset_host'
require 'sinatra'

class CaressApp < Sinatra::Base
  enable :logging, :dump_errors

  get "*" do
    params[:splat].first.split(",").map do |asset_path|
      Caress::AssetHost[asset_path] || not_found
    end.join
  end
end
