module Caress
  class AssetHost
    def self.configure(configuration)
      asset_path = configuration["asset_path"]
      self.asset_host = (asset_path == ":memory:") ? MemoryAssetHost.new : FileAssetHost.new(asset_path)
    end

    def self.[](*args)
      asset_host.find(*args)
    end

    def self.[]=(*args)
      asset_host.store(*args)
    end

    def self.asset_host; @asset_host ||= MemoryAssetHost.new; end
    def self.asset_host=(asset_host)
      @asset_host = asset_host
    end
  end # AssetHost

  class FileAssetHost
    attr_reader :root
    def initialize(root_path)
      @root = root_path
    end
  end # FileAssetHost

  class MemoryAssetHost < Hash
    def initialize(database=nil)
      super()
      update(database || {})
    end

    def find(path_to_asset) self[path_to_asset]; end
    def store(path_to_asset, contents) self[path_to_asset] = contents; end
  end # MemoryAsset
end # Caress
