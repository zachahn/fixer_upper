require "test_helper"

class RendererTest < TestCase
  def test_undefined_engines
    renderer =
      FixerUpper::Renderer.new(
        engine_registry: {},
        content: "",
        filename: "foo.bar.baz"
      )

    assert_equal(%w[baz bar], renderer.engines)
  end

  def test_predefined_engines
    renderer =
      FixerUpper::Renderer.new(
        engine_registry: {},
        content: "",
        filename: "foo.bar.baz",
        engines: %i[lol hi]
      )

    assert_equal(%w[hi lol], renderer.engines)
  end
end
