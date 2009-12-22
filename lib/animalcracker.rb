require 'animalcracker/asset_host'
require 'sinatra'

module AnimalCracker
  module Server

    def self.extended(base)
      base.get("*") do
        begin
          params[:splat].first.split(",").map do |asset_path|
            AssetHost[asset_path] || not_found
          end.join
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
