$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "fixer_upper"

require "minitest/autorun"
require "pry"

class TestCase < Minitest::Test
end
