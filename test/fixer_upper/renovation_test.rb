require "test_helper"

class RenovationTest < TestCase
  def test_diy
    registry = { "upcase" => -> (text) { text.upcase } }
    fixer_upper = FixerUpper::Renovation.new(registry, {})

    output =
      fixer_upper.diy(
        text: "hi",
        engines: ["upcase"],
        options: {},
        bang: false
      )
    assert_equal("HI", output)
  end

  def test_diy!
    fixer_upper = FixerUpper::Renovation.new({}, {})

    assert_raises(FixerUpper::Error::EngineNotFound) do
      fixer_upper.diy(
        text: "hi",
        engines: ["does_not_exist"],
        options: {},
        bang: true
      )
    end
  end

  def test_has_filename
    engines = {
      "txt" => proc { |text, _filepath_:| "#{text.strip} | #{_filepath_}" },
    }

    renovation = FixerUpper::Renovation.new(engines, {})
    output =
      renovation.renovate(
        filepath: "test/fixtures/tiny.txt",
        options: {},
        bang: true
      )

    assert_equal("hi | test/fixtures/tiny.txt", output)
  end

  def test_hasnt_filename
    engines = {
      "txt" => proc { |text, _filepath_:| "#{text.strip} | #{_filepath_}" },
    }

    renovation = FixerUpper::Renovation.new(engines, {})
    output =
      renovation.diy(
        text: "hi",
        engines: ["txt"],
        options: {},
        bang: true
      )

    assert_equal("hi | ", output)
  end
end
