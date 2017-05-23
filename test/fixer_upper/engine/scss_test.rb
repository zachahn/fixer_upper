require "test_helper"

class EngineScssTest < TestCase
  def test_default_settings
    fu = FixerUpper.new
    fu.register("scss", to: FixerUpper::Engine::Scss.new)

    output = fu.renovate("foo.scss", "$color: #ccc;\nbody { color: $color }")

    assert_equal("body {\n  color: #ccc; }\n", output)
  end

  def test_has_filename_in_errors
    fu = FixerUpper.new
    fu.register("scss", to: FixerUpper::Engine::Scss.new)

    error =
      begin
        fu.renovate("path/to/foo.scss", "body { color: $color }")
      rescue Sass::SyntaxError => e
        e
      end

    assert_equal("path/to/foo.scss", error.sass_filename)
  end
end
