require 'teststrap'

context "Memory Asset Host" do
  setup do
    Caress::MemoryAssetHost.new({"/bar" => "juice"})
  end

  should("return nil if asset not found") { topic.find("/foo") }.nil
  should("return asset contents if defined") { topic.find("/bar") }.equals("juice")

  should("allow asset to be defined") do
    topic.store("/bar/man", "bouncer")
    topic.find("/bar/man")
  end.equals("bouncer")
end # Memory Asset Host

context "Memory Asset Host accessed as Caress::AssetHost" do
  setup do
    Caress::AssetHost.asset_host = Caress::MemoryAssetHost.new({"/dude" => "lebowski"})
    Caress::AssetHost
  end

  asserts("asset host") { topic.asset_host }.kind_of(Caress::MemoryAssetHost)
end # Memory Asset Host accessed as Caress::AssetHost
