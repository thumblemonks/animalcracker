require 'animalcracker/asset_host'
require 'sinatra'

module AnimalCracker
  module Server

    def get_assets(root_path="")
      get("#{root_path}/*") do
        begin
          "/#{params[:splat].first}".split(",").map { |asset_path| AssetHost[asset_path] || not_found }
        rescue NotFound
          not_found
        end
      end
    end

  end # Server
end # AnimalCracker

module Sinatra
  register AnimalCracker::Server
end
