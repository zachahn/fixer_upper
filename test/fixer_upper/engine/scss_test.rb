require "test_helper"

class EngineScssTest < TestCase
  def test_default_settings
    fu = FixerUpper.new
    fu.register("scss", to: FixerUpper::Engine::Scss.new)

    output = fu.renovate("foo.scss", "$color: #ccc;\nbody { color: $color }")

    assert_equal("body {\n  color: #ccc; }\n", output)
  end
end
