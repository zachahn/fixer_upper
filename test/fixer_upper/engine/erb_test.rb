require "test_helper"

class EngineErbTest < TestCase
  def test_it_yields
    fu = FixerUpper.new
    fu.register("erb", to: FixerUpper::Engine::Erb.new, scope: Object.new)

    output =
      fu.renovate("foo.txt.erb", "hello <%= yield %>") do
        "world"
      end

    assert_equal("hello world", output)
  end

  def test_scope
    scope = Object.new
    scope.define_singleton_method(:name) { "Jacobim Mugatu" }

    fu = FixerUpper.new
    fu.register("erb", to: FixerUpper::Engine::Erb.new, scope: scope)

    output = fu.renovate("foo.txt.erb", "hello <%= name %>")

    assert_equal("hello Jacobim Mugatu", output)
  end

  def test_nested
    scope = Object.new
    scope.define_singleton_method(:name) { "Jacobim Mugatu" }

    fu = FixerUpper.new
    fu.register("erb", to: FixerUpper::Engine::Erb.new, scope: scope)

    output =
      fu.renovate("foo.txt.erb", "hello <%= yield %>") do
        fu.renovate("_name.txt.erb", "<%= name %>")
      end

    assert_equal("hello Jacobim Mugatu", output)
  end
end
