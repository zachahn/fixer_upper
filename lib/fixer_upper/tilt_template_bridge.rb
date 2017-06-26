class FixerUpper
  class TiltTemplateClassBridge
    def initialize(engine, options)
      @tilt_engine_class = engine
      @options = options
    end

    def new(filename, content)
      tilt_engine = @tilt_engine_class.new(filename, 1, @options) { content }

      TiltTemplateInstanceBridge.new(tilt_engine)
    end
  end

  class TiltTemplateInstanceBridge
    def initialize(tilt_engine)
      @tilt_engine = tilt_engine
    end

    def render(view_scope, &block)
      @tilt_engine.render(view_scope, {}, &block)
    end
  end
end
