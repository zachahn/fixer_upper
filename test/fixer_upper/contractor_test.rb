require "test_helper"

class ContractorTest < TestCase
  def test_undefined_engines
    contractor =
      FixerUpper::Contractor.new(
        engine_registry: {},
        content: "",
        filename: "foo.bar.baz"
      )

    assert_equal(%w[baz bar], contractor.engines)
  end

  def test_predefined_engines
    contractor =
      FixerUpper::Contractor.new(
        engine_registry: {},
        content: "",
        filename: "foo.bar.baz",
        engines: %i[lol hi]
      )

    assert_equal(%w[hi lol], contractor.engines)
  end
end
