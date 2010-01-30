require 'teststrap'

context "A compound request with javascript specific resources" do
  setup do
    AnimalCracker::AssetHost.asset_host.clear
    mock_app do
      register AnimalCracker::Server
      get_assets
      # TODO: Use rr here instead
      AnimalCracker::AssetHost["/foo/bar.js"] = "var a='bar';\nvar b='bar';\n"
      AnimalCracker::AssetHost["/foo/baz.js"] = "/*\n * blah\n */\nfunction f(a, b)\n{\n return (a);\n  }\n"
    end
    get "/foo/bar.js,baz.js"
  end

  asserts_response_status 200
  asserts_response_body "var a='bar';var b='bar';function f(a,b)\n{return(a);}"
end # A compound request with javascript specific resources
