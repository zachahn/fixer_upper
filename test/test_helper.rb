$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "fixer_upper"

require "minitest/autorun"
require "pry"

require_relative "support"

class TestCase < Minitest::Test
  include TestCaseEngines
end
