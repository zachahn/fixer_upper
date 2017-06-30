require "test_helper"

class FixerUpperTest < TestCase
  def test_it_figures_out_engines_from_filename
    renderer = new_fixer_upper.renderer(
      filename: "cool.txt.erb",
      engines: %w[erb txt],
      content: %(this file is <%= "cool" %>),
      view_scope: BasicObject.new
    )

    assert_equal("this file is cool", renderer.call)
  end

  def test_it_uses_specified_engines
    renderer = new_fixer_upper.renderer(
      filename: "cool.txt.erb",
      content: %(this file is <%= "cool".length %>),
      view_scope: BasicObject.new,
      engines: %i[erb upcase]
    )

    assert_equal(%(THIS FILE IS 4), renderer.call)
  end

  def test_yield_works
    renderer = new_fixer_upper.renderer(
      filename: "cool.txt.erb",
      engines: %w[erb txt],
      content: %(this file is <%= yield %>),
      view_scope: BasicObject.new,
      block: -> { "cool" }
    )

    assert_equal("this file is cool", renderer.call)
  end

  private

  class Upcase
    def initialize(_, memo)
      @memo = memo
    end

    def render(*)
      @memo.upcase
    end
  end

  def new_fixer_upper
    fixer_upper = FixerUpper.new
    fixer_upper.register("upcase", engine: Upcase)
    fixer_upper.register_tilt("erb", engine: Tilt::ERBTemplate)

    fixer_upper
  end
end
