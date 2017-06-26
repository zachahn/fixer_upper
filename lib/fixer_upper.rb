require "tilt"

require "fixer_upper/contractor"
require "fixer_upper/error"
require "fixer_upper/version"

class FixerUpper
  def initialize
    @engine_registry = {}
  end

  def register(*names, engine)
    names.each do |name|
      register_single(name, engine)
    end

    true
  end

  def contractor(**args)
    Contractor.new(engine_registry: @engine_registry, **args)
  end

  private

  def register_single(name, engine)
    @engine_registry[name.to_s] = engine
  end
end
