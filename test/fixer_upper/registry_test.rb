require "test_helper"

class RegistryTest < TestCase
  def test_registration_of_tilt
    registry = FixerUpper::Registry.new
    registry.register(:erb, engine: Tilt::ERBTemplate)

    assert_kind_of(FixerUpper::TiltTemplateClassBridge, registry[:erb])
  end

  def test_registration_of_fixer_upper
    registry = FixerUpper::Registry.new
    registry.register(:idk, engine: SomeCoolTemplateThatWorks)

    assert_equal(SomeCoolTemplateThatWorks, registry[:idk])
  end

  def test_non_tilt_template_engines_cant_have_options
    registry = FixerUpper::Registry.new

    assert_raises(FixerUpper::Error::EngineDoesntAcceptOptions) do
      opts = { foo: :bar }
      registry.register(:idk, engine: SomeCoolTemplateThatWorks, options: opts)
    end
  end

  def test_cant_double_register
    registry = FixerUpper::Registry.new

    assert_raises(FixerUpper::Error::MultipleEnginesForOneName) do
      registry.register(:idk, engine: SomeCoolTemplateThatWorks)
      registry.register(:idk, engine: SomeOtherTemplateThatWorks)
    end
  end

  def test_can_register_identical_engine_with_different_extension
    registry = FixerUpper::Registry.new

    registry.register(:idk, engine: SomeCoolTemplateThatWorks)
    registry.register(:lol, engine: SomeCoolTemplateThatWorks)
  end

  class SomeCoolTemplateThatWorks
    def initialize(_filename, _content)
    end

    def render(_view_scope, &_block)
      "works"
    end
  end

  class SomeOtherTemplateThatWorks
    def initialize(_filename, _content)
    end

    def render(_view_scope, &_block)
      "also works"
    end
  end
end
