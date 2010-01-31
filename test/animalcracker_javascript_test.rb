require 'teststrap'

context "A compound request with javascript specific resources" do
  setup do
    mock(Smurf::Javascript).minify("bar;baz") { "HELLO WORLD" }
    AnimalCracker::AssetHost.asset_host.clear
    AnimalCracker::AssetHost["/foo/bar.js"] = "bar;"
    AnimalCracker::AssetHost["/foo/baz.js"] = "baz"

    mock_app do
      register AnimalCracker::Server
      get_assets
    end

    get "/foo/bar.js,baz.js"
  end

  asserts_response_status 200
  asserts_response_body "HELLO WORLD"
end # A compound request with javascript specific resources
