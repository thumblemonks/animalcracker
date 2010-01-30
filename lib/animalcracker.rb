require 'animalcracker/asset_host'
require 'smurf'
require 'sinatra'
require 'md5'

module AnimalCracker
  module Server

    def self.extended(app)
      app.helpers do
        def javascript_file?(filename) filename =~ /\.js$/i; end
      end
    end

    def get_assets(root_path="")
      get("#{root_path}/*") do
        asset_paths = "/#{params[:splat].first}".split(",")
        assumed_base_path = Pathname(asset_paths.first).parent
        content = asset_paths.map do |asset_path|
          AssetHost[asset_path] || AssetHost[(assumed_base_path + asset_path).to_s] || not_found
        end.join
        # TODO: get this junk and the stuff about concatentating files out of here and into a builder
        if javascript_file?(asset_paths.first)
          content = Smurf::Javascript.minify(content)
        end
        etag(Digest::MD5.hexdigest(content))
        content
      end # get
    end # get_assets

  end # Server
end # AnimalCracker

module Sinatra
  register AnimalCracker::Server
end
