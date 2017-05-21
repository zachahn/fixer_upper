$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "fixer_upper"
require "fixer_upper/engine/erb"
require "fixer_upper/engine/cmark"

require "pry"

require "erb"
require "commonmarker"

require "minitest/autorun"

class TestCase < Minitest::Test
end
