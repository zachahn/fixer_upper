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

      assert_equal(eval(expected_result), eval(sample))
    end
  end
end
