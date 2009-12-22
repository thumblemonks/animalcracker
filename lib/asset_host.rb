require 'pathname'

module Caress
  class ReadOnly < Exception; end

  # Generic asset hosting proxy. Will default to MemoryAssetHost unless configured otherwise
  class AssetHost
    class << self
      def configure(configuration)
        asset_path = configuration["asset_path"]
        self.asset_host = (asset_path == ":memory:") ? MemoryAssetHost.new : FileAssetHost.new(asset_path)
      end

      def [](*args) asset_host.find(*args); end
      def []=(*args) asset_host.store(*args); end

      def asset_host; @asset_host ||= MemoryAssetHost.new; end
      def asset_host=(asset_host) @asset_host = asset_host; end
    end
  end # AssetHost

  # Interface for retrieving assets from the filesystem given some root path.
  class FileAssetHost
    attr_reader :root
    def initialize(root_path)
      @root = Pathname(root_path)
    end

    def find(path_to_asset)
      (@root + path_to_asset.gsub(/^\//, '')).read
    end

    def store(path_to_asset, contents) raise(ReadOnly, "Cannot store files with FileAssetHost"); end
  end # FileAssetHost

  # Basically, a hash of pathnames to file-contents. Useful for testing, but maybe even other things.
  class MemoryAssetHost < Hash
    def initialize(database=nil)
      super()
      update(database || {})
    end

    def find(path_to_asset) self[path_to_asset]; end
    def store(path_to_asset, contents) self[path_to_asset] = contents; end
  end # MemoryAsset
end # Caress
