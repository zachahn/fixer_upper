require "test_helper"

class FixerUpperTest < TestCase
  def test_multiple_keys
    fixer_upper = FixerUpper.new
    fixer_upper.register("txt", "text", to: Identity.new)

    assert_kind_of(Identity, fixer_upper.for("txt"))
    assert_kind_of(Identity, fixer_upper.for("text"))
  end

  def test_default_options
    fixer_upper = FixerUpper.new
    fixer_upper.register("txt", "text", to: Identity.new, jk: true)

    assert_equal("", fixer_upper.diy("hi", "txt"))
  end

  def test_string_conversion
    fixer_upper = FixerUpper.new
    fixer_upper.register("rot13", to: Rotate.new(13))

    assert_equal("<pnrfne>", fixer_upper.renovate("file.rot13", "<caesar>"))
  end

  def test_it_reads_file_contents
    fixer_upper = FixerUpper.new
    fixer_upper.register("txt", to: Shout.new)

    assert_equal("HI\n", fixer_upper.renovate("test/fixtures/tiny.txt"))
  end
end
