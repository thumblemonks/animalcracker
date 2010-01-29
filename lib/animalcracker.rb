require 'animalcracker/asset_host'
require 'sinatra'
require 'sha1'

module AnimalCracker
  module Server

    def get_assets(root_path="")
      get("#{root_path}/*") do
        begin
          asset_paths = "/#{params[:splat].first}".split(",")
          content = asset_paths.map { |asset_path| AssetHost[asset_path] || not_found }.join
          etag(Digest::SHA2.hexdigest(content))
          content
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
