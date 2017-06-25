require "test_helper"

class FixerUpperTest < TestCase
  def test_it_figures_out_engines_from_filename
    worker = new_fixer_upper.contractor(
      filename: "cool.txt.erb",
      content: %(this file is <%= "cool" %>),
      view_scope: BasicObject.new
    )

    assert_equal("this file is cool", worker.call)
  end

  def test_it_uses_specified_engines
    worker = new_fixer_upper.contractor(
      filename: "cool.txt.erb",
      content: %(this file is <%= "cool".length %>),
      view_scope: BasicObject.new,
      engines: %i[upcase erb]
    )

    assert_equal(%(THIS FILE IS 4), worker.call)
  end

  def test_yield_works
    worker = new_fixer_upper.contractor(
      filename: "cool.txt.erb",
      content: %(this file is <%= yield %>),
      scope: BasicObject.new,
      block: -> { "cool" }
    )

    assert_equal("this file is cool", worker.call)
  end

  private

  class Upcase
  end

  def new_fixer_upper
    fixer_upper = FixerUpper.new
    fixer_upper.register("upcase", Upcase.new)

    fixer_upper
  end
end
