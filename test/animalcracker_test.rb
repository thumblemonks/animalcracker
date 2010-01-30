require 'teststrap'

context "AnimalCracker Server without an asset path defined" do
  setup do
    mock_app do
      register AnimalCracker::Server
      AnimalCracker::AssetHost["/some/asset.ext"] = "Foo"
    end
    get "/some/asset.ext"
  end

  asserts_response_status 404
end # AnimalCracker Server without an asset path defined

context "Default AnimalCracker Server:" do
  setup do
    AnimalCracker::AssetHost.asset_host.clear
    mock_app do
      register AnimalCracker::Server
      get_assets
    end
  end

  context "unable to find basic asset" do
    setup { get "/some/asset.ext" }
    asserts_response_status 404
  end # unable to find basic asset

  context "get a basic asset" do
    setup do
      AnimalCracker::AssetHost["/some/asset.ext"] = "Foo"
      get "/some/asset.ext"
    end

    asserts_response_status 200
    asserts_response_body "Foo"
    asserts "etag on content" do
      last_response.headers["ETag"]
    end.equals('"' + Digest::MD5.hexdigest("Foo") + '"')
  end # get a basic asset

  context "get a grouping of assets" do
    setup do
      AnimalCracker::AssetHost["/foo/bar"] = "function a() {}"
      AnimalCracker::AssetHost["/goo/car"] = "function b() {}"
      get "/foo/bar,/goo/car"
    end

    asserts_response_status 200
    asserts_response_body "function a() {}function b() {}"
  end # get a grouping of assets

end # Default AnimalCracker Server

context "AnimalCracker Server with custom path" do
  setup do
    mock_app do
      register AnimalCracker::Server
      get_assets "/assets"
      AnimalCracker::AssetHost["/some-asset.ext"] = "Foo"
    end
  end

  context "unable to find basic asset" do
    setup { get "/some-asset.ext" }
    asserts_response_status 404
  end # unable to find basic asset

  context "asset found with right base path" do
    setup { get "/assets/some-asset.ext" }
    asserts_response_status 200
    asserts_response_body "Foo"
  end # asset found with right base path

end # AnimalCracker Server with custom path

context "A compound request with relative paths" do
  setup do
    AnimalCracker::AssetHost.asset_host.clear
    mock_app do
      register AnimalCracker::Server
      get_assets
      AnimalCracker::AssetHost["/foo/bar.ext"] = "Bar"
      AnimalCracker::AssetHost["/foo/baz.ext"] = "Baz"
    end
    get "/foo/bar.ext,baz.ext"
  end

  asserts_response_status 200
  asserts_response_body "BarBaz"
end # A compound request with relative paths
