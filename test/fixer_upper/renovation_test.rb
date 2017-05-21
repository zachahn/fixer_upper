require "test_helper"

class RenovationTest < TestCase
  def test_diy
    fixer_upper = FixerUpper.new
    fixer_upper["upcase"] = -> (text) { text.upcase }

    assert_equal("HI", fixer_upper.diy("hi", "upcase"))
  end

  def test_diy!
    fixer_upper = FixerUpper.new

    assert_raises(FixerUpper::Error::EngineNotFound) do
      fixer_upper.diy!("hi", "does_not_exist")
    end
  end
end
