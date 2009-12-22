require 'teststrap'

context "Caress App:" do
  setup { @app = Caress::App }

  context "unable to find basic asset" do
    setup { get "/some/asset.ext" }
    asserts_response_status 404
  end # unable to find basic asset

  context "get a basic asset" do
    setup do
      Caress::AssetHost["/some/asset.ext"] = "Foo"
      get "/some/asset.ext"
    end

    asserts_response_status 200
    asserts_response_body "Foo"
  end # get a basic asset

  context "get a grouping of assets" do
    setup do
      Caress::AssetHost["/foo/bar"] = "function a() {}"
      Caress::AssetHost["/goo/car"] = "function b() {}"
      get "/foo/bar,/goo/car"
    end

    asserts_response_status 200
    asserts_response_body "function a() {}function b() {}"
  end # get a grouping of assets

end # Caress App
