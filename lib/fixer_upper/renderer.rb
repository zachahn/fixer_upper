class FixerUpper
  class Renderer
    attr_reader :engines

    def initialize(engine_registry:,
      filename:,
      content:,
      engines:,
      view_scope: nil,
      block: nil)
      @engine_registry = engine_registry

      @filename = filename
      @content = content
      @engines = engines || []
      @view_scope = view_scope
      @block = block
    end

    def call
      @engines.reduce(@content) do |memo, engine|
        if @engine_registry.engine?(engine)
          render_engine(engine, memo)
        else
          memo
        end
      end
    end

    private

    def render_engine(engine, memo)
      fixer_upper_engine_class = @engine_registry[engine]

      fixer_upper_engine = fixer_upper_engine_class.new(@filename, memo)

      fixer_upper_engine.render(@view_scope, &@block)
    end

    def compute_extensions
      basename = File.basename(@filename)
      basename.split(".")[1..-1]
    end
  end
end
