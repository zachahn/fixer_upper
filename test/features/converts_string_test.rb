require "test_helper"

class ConvertsStringTest < TestCase
  def test_it_works
    transmog = Transmog::Rifier.new
    transmog["erb"] = Transmog::Engine::Erb.new(OpenStruct.new(foo: "hi"))
    transmog["md"] = Transmog::Engine::Cmark.new

    assert_equal("<h1>hi</h1>\n", transmog.rify("foo.md.erb", "# <%= foo %>"))
  end
end
