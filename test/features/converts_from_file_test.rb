require "test_helper"

class ConvertsFromFileTest < TestCase
  class Shout
    def call(text)
      text.upcase
    end
  end

  def test_it_reads_file_contents
    fixer_upper = FixerUpper.new
    fixer_upper["txt"] = Shout.new

    assert_equal("HI\n", fixer_upper.renovate("test/fixtures/tiny.txt"))
  end
end
