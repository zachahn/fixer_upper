require "test_helper"

class RenovationTest < TestCase
  def test_diy
    registry = { "upcase" => -> (text) { text.upcase } }
    fixer_upper = FixerUpper::Renovation.new(registry, {})

    assert_equal("HI", fixer_upper.diy("hi", "upcase", bang: false))
  end

  def test_diy!
    fixer_upper = FixerUpper::Renovation.new({}, {})

    assert_raises(FixerUpper::Error::EngineNotFound) do
      fixer_upper.diy("hi", "does_not_exist", bang: true)
    end
  end
end
