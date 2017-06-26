require "forwardable"

require "tilt"

require "fixer_upper/contractor"
require "fixer_upper/error"
require "fixer_upper/registry"
require "fixer_upper/tilt_template_bridge"
require "fixer_upper/version"

class FixerUpper
  extend Forwardable

  def_delegator :@engine_registry, :register
  def_delegator :@engine_registry, :register_tilt

  def initialize
    @engine_registry = Registry.new
  end

  def contractor(**args)
    Contractor.new(engine_registry: @engine_registry, **args)
  end
end
