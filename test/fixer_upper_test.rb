require "test_helper"

class FixerUpperTest < TestCase
  class Identity
    def call(text)
      text
    end
  end

  def test_multiple_keys
    fixer_upper = FixerUpper.new
    fixer_upper["txt", "text"] = Identity.new

    assert_kind_of(Identity, fixer_upper["txt"])
    assert_kind_of(Identity, fixer_upper["text"])
  end
end
