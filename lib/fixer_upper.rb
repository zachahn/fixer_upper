require "fixer_upper/error"
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
    @renovation.renovate(filepath, contents, bang: false)
  end

  def renovate!(filepath, contents = nil)
    @renovation.renovate(filepath, contents, bang: true)
  end

  def diy(text, engines)
    @renovation.diy(text, engines, bang: false)
  end

  def diy!(text, engines)
    @renovation.diy(text, engines, bang: true)
  end
end
