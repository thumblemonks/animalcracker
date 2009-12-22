require 'animalcracker/asset_host'
require 'sinatra'

module AnimalCracker
  class Server < Sinatra::Base

    enable :logging, :dump_errors

    get "*" do
      begin
        params[:splat].first.split(",").map do |asset_path|
          AssetHost[asset_path] || not_found
        end.join
      rescue NotFound
        not_found
      end
    end # get *

  end # Server
end # AnimalCracker
