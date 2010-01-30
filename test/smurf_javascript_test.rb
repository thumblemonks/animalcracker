require "teststrap"

# I am certain there are more tests, but I borrowed this code from the webs. When I write my own better
# minifier, I'll write the complete test suite.
context "A javascript minifier" do
  setup do
    def minify(str) Smurf::Javascript.minify(str); end
  end

  should("remove comments") { minify("// blah\nvar a='b';") }.equals("var a='b';")

  should("remove extra spaces") { minify("var  a  =  'b' ; ") }.equals("var a='b';")

  should("remove useless newlines") do
    minify("var a=\n'b';\nfunction a() {\ndo b;\n return c;\n}\n")
  end.equals("var a='b';function a(){do b;return c;}")
end # Minifying Javascript
