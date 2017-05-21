require "fixer_upper/renovation"
require "fixer_upper/version"

class FixerUpper
  def initialize
    @engine_registry = {}
    @renovation = Renovation.new(@engine_registry)
  end

  def []=(*keys, engine)
    keys.each do |key|
      @engine_registry[key] = engine
    end
  end

  def [](key)
    @engine_registry[key]
  end

  def renovate(filepath, contents = nil)
    @renovation.call(filepath, contents)
  end
end
