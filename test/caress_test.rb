require 'teststrap'

context "Caress" do
  setup do
    @app = CaressApp
    Caress::Asset["/some/asset.ext"] = "Foo"
  end

  context "get /some/asset.ext" do
    setup do
      get "/some/asset.ext"
    end

    assert_response_status 200
    assert_response_body "Foo"
  end # get /some/asset.ext
end # Caress