$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "transmog"
require "transmog/engine/erb"
require "transmog/engine/cmark"

require "pry"

require "erb"
require "commonmarker"

require "minitest/autorun"

class TestCase < Minitest::Test
end
