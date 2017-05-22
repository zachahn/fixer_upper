require "test_helper"

class FixerUpperTest < TestCase
  class Identity
    def call(text, **options)
      if options[:jk]
        return ""
      end

      text
    end
  end

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

  class Shout
    def call(text)
      text.upcase
    end
  end

  def test_multiple_keys
    fixer_upper = FixerUpper.new
    fixer_upper["txt", "text"] = Identity.new

    assert_kind_of(Identity, fixer_upper["txt"])
    assert_kind_of(Identity, fixer_upper["text"])
  end

  def test_default_options
    fixer_upper = FixerUpper.new
    fixer_upper.register("txt", "text", to: Identity.new, jk: true)

    assert_equal("", fixer_upper.diy("hi", "txt"))
  end

  def test_string_conversion
    fixer_upper = FixerUpper.new
    fixer_upper["rot13"] = Rotate.new(13)

    assert_equal("<pnrfne>", fixer_upper.renovate("file.rot13", "<caesar>"))
  end

  def test_it_reads_file_contents
    fixer_upper = FixerUpper.new
    fixer_upper["txt"] = Shout.new

    assert_equal("HI\n", fixer_upper.renovate("test/fixtures/tiny.txt"))
  end
end
