require 'asset_host'
require 'sinatra'

module Caress
  class App < Sinatra::Base

    enable :logging, :dump_errors

    get "*" do
      begin
        params[:splat].first.split(",").map do |asset_path|
          Caress::AssetHost[asset_path] || not_found
        end.join
      rescue NotFound
        not_found
      end
    end # get *

  end # App
end # Caress
