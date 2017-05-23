$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "fixer_upper"

require "minitest/autorun"
require "pry"
require "erb"
require "sass"

require_relative "support"

Dir.glob(File.expand_path("../../lib/fixer_upper/engine/**/*.rb", __FILE__))
  .each { |path| require path }

class TestCase < Minitest::Test
  include TestCaseEngines
end
