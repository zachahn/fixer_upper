$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "fixer_upper"

require "pry"

require "erb"

require "minitest/autorun"

class TestCase < Minitest::Test
end
