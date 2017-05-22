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
end
