require "test_helper"

class ConvertsStringTest < TestCase
  class Rotate
    def initialize(amount)
      @amount = amount
    end

    def call(text)
      n = "A".ord + @amount - 1
      n_ = "A".ord + @amount
      split = "#{n_.chr}-ZA-#{n.chr}"

      text.tr("A-Za-z", split.upcase + split.downcase)
    end
  end

  def test_it_works
    fixer_upper = FixerUpper.new
    fixer_upper["rot13"] = Rotate.new(13)

    assert_equal("<pnrfne>", fixer_upper.renovate("file.rot13", "<caesar>"))
  end
end
