class FixerUpper
  class Contractor
    def initialize(engine_registry:,
      filename:,
      content:,
      engines: [],
      view_scope: nil,
      block: nil)
      @engine_registry = engine_registry

      @filename = filename
      @content = content
      @engines = engines
      @view_scope = view_scope
      @block = block
    end

    def call
      engines.reduce(@content) do |memo, engine|
        if @engine_registry.key?(engine)
          render_fixer_upper(engine, memo)
        elsif Tilt[engine]
          render_tilt(engine, memo)
        else
          memo
        end
      end
    end

    def engines
      computed_engines =
        if @engines.any?
          @engines.map(&:to_s)
        else
          compute_extensions
        end

      computed_engines.reverse
    end

    private

    def render_fixer_upper(engine, memo)
      fixer_upper_engine_class = @engine_registry[engine]

      fixer_upper_engine = fixer_upper_engine_class.new(@filename, memo)

      fixer_upper_engine.render(@view_scope, &@block)
    end

    def render_tilt(engine, memo)
      tilt_engine_class = Tilt[engine]

      tilt_engine = tilt_engine_class.new(@filename, 1, {}) { memo }

      tilt_engine.render(@view_scope, {}, &@block)
    end

    def compute_extensions
      basename = File.basename(@filename)
      basename.split(".")[1..-1]
    end
  end
end
