require "test_helper"

class RenovationTest < TestCase
  def test_diy
    registry = { "upcase" => -> (text) { text.upcase } }
    fixer_upper = FixerUpper::Renovation.new(registry, {})

    output = fixer_upper.diy(text: "hi", engines: ["upcase"], bang: false)
    assert_equal("HI", output)
  end

  def test_diy!
    fixer_upper = FixerUpper::Renovation.new({}, {})

    assert_raises(FixerUpper::Error::EngineNotFound) do
      fixer_upper.diy(text: "hi", engines: ["does_not_exist"], bang: true)
    end
  end
end
