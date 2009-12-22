require 'teststrap'

context "A File Asset Host" do
  setup do
    @root = Pathname.new(__FILE__).dirname + "../tmp/caress"
    (@root + "foo").mkpath
    Caress::FileAssetHost.new(@root.realpath)
  end

  asserts("store") do
    topic.store("a", "b")
  end.raises(Caress::ReadOnly, "Cannot store files with FileAssetHost")

  asserts("find scopes search to root path") do
    (@root + "foo/bar").open("w+") { |f| f.write("disco jaws") }
    topic.find("/foo/bar")
  end.equals("disco jaws")

  asserts("nonexistent file") do
    topic.find("/foo/barge")
  end.raises(Caress::NotFound, "Could not find /foo/barge")
  
  teardown { @root.rmtree }
end # A File Asset Host
