require "fixer_upper/error"
require "fixer_upper/renovation"
require "fixer_upper/version"

class FixerUpper
  def initialize
    @engine_registry = {}
    @options_registry = {}
    @renovation = Renovation.new(@engine_registry, @options_registry)
  end

  def register(*keys, to:, **options)
    keys.each do |key|
      @engine_registry[key] = to
      @options_registry[key] = options
    end
  end

  def for(key)
    @engine_registry[key]
  end

  def renovate(filepath, contents = nil, **options)
    @renovation.renovate(
      filepath: filepath,
      text: contents,
      options: options,
      bang: false
    )
  end

  def renovate!(filepath, contents = nil, **options)
    @renovation.renovate(
      filepath: filepath,
      text: contents,
      options: options,
      bang: true
    )
  end

  def diy(text, *engines, **options)
    @renovation.diy(text: text, engines: engines, options: options, bang: false)
  end

  def diy!(text, *engines, **options)
    @renovation.diy(text: text, engines: engines, options: options, bang: true)
  end
end
