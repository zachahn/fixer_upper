require "fixer_upper/renovation"
require "fixer_upper/version"

class FixerUpper
  def initialize
    @engine_registry = {}
    @renovation = Renovation.new(@engine_registry)
  end

  def []=(key, engine)
    @engine_registry[key] = engine
  end

  def renovate(filepath, contents = nil)
    @renovation.call(filepath, contents)
  end
end
