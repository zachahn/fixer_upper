require "forwardable"

require "tilt"

require "fixer_upper/error"
require "fixer_upper/engine_registry"
require "fixer_upper/renderer"
require "fixer_upper/tilt_template_bridge"
require "fixer_upper/version"

class FixerUpper
  extend Forwardable

  def_delegator :@engine_registry, :register
  def_delegator :@engine_registry, :register_tilt

  def initialize
    @engine_registry = EngineRegistry.new
  end

  def renderer(**args)
    Renderer.new(engine_registry: @engine_registry, **args)
  end
end
