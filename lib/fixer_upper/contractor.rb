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

    def compute_extensions
      basename = File.basename(@filename)
      basename.split(".")[1..-1]
    end
  end
end
