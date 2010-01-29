require 'teststrap'

context "Memory Asset Host" do
  setup do
    AnimalCracker::MemoryAssetHost.new({"/bar" => "juice"})
  end

  asserts("nonexistent asset") do
    topic.find("/foo")
  end.raises(AnimalCracker::NotFound, "Could not find /foo")

  should("return asset contents if defined") { topic.find("/bar") }.equals("juice")

  should("allow asset to be defined") do
    topic.store("/bar/man", "bouncer")
    topic.find("/bar/man")
  end.equals("bouncer")

  asserts("clearing the host's memory first") do
    topic.store("/bar/man", "bouncer")
    topic.clear
    topic.find("/bar/man")
  end.raises(AnimalCracker::NotFound, "Could not find /bar/man")
end # Memory Asset Host

context "Memory Asset Host accessed as AnimalCracker::AssetHost" do
  setup do
    AnimalCracker::AssetHost.asset_host = AnimalCracker::MemoryAssetHost.new({"/dude" => "lebowski"})
    AnimalCracker::AssetHost
  end

  asserts("asset host") { topic.asset_host }.kind_of(AnimalCracker::MemoryAssetHost)
end # Memory Asset Host accessed as AnimalCracker::AssetHost
