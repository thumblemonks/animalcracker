require 'teststrap'

context "Configuring Asset Host" do
  setup { Caress::AssetHost }

  asserts("default asset host") { topic.asset_host }.kind_of(Caress::MemoryAssetHost)

  context "when asset_path is :memory:" do
    setup do
      topic.configure({"asset_path" => ":memory:"})
      topic.asset_host
    end

    asserts_topic.kind_of(Caress::MemoryAssetHost)
  end # when asset_path is :memory:

  context "when asset_path does not match :memory:" do
    setup do
      topic.configure({"asset_path" => "/tmp"})
      topic.asset_host
    end

    asserts_topic.kind_of(Caress::FileAssetHost)
    asserts("root path") { topic.root }.equals("/tmp")
  end # when asset_path does not match :memory:

  context "using proxy methods" do
    mocha_support

    should "call proxy [] to find on actual asset host" do
      topic.asset_host.expects(:find).with("/baz").returns("happy ending")
      topic["/baz"]
    end.equals("happy ending")

    should "call proxy []= to store on actual asset host" do
      topic.asset_host.expects(:store).with("/bax", "jaw")
      topic["/bax"] = "jaw"
    end
  end # using proxy methods

end # Configuring Asset Host
