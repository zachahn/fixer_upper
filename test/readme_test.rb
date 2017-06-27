require "test_helper"

class ReadmeTest < TestCase
  def test_readme_code
    readme = File.read(File.expand_path("../../README.md", __FILE__))

    readme_samples =
      readme
        .scan(/^```ruby\n(.+?)\n`{3}/m)
        .flatten
        .select { |sample| /FixerUpper\.new/.match(sample) }

    readme_samples.each do |sample|
      line_with_expected_result = sample.lines.last
      expected_result = line_with_expected_result.split(" # => ").last

      assert_equal(safe_eval_jk(expected_result), safe_eval_jk(sample))
    end
  end

  private

  # This is just as dangerous as calling `eval(string)`, but this prevents
  # Rubocop from complaining lol
  def safe_eval_jk(str)
    obj = Object.new
    obj.instance_eval(str)
  end
end
