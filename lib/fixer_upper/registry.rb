class FixerUpper
  class Registry
    def initialize
      @engines = {}
    end

    def register(*names, engine:)
      names.each do |name|
        register_single(name, engine)
      end
    end

    def register_tilt(*names, engine:, options: {})
      engine_bridge = create_tilt_bridge(engine, options)

      names.each do |name|
        register_single(name, engine_bridge)
      end
    end

    def engine?(engine)
      @engines.key?(engine.to_s)
    end

    def [](engine_name)
      @engines[engine_name]
    end

    private

    def create_tilt_bridge(engine, options)
      TiltTemplateClassBridge.new(engine, options)
    end

    def register_single(name, engine)
      @engines[name.to_s] = engine
    end
  end
end
