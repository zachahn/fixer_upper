class FixerUpper
  class EngineRegistry
    def initialize
      @engines = {}
    end

    def register(*names, engine:, options: {})
      if definitely_like_tilt_template?(engine)
        register_tilt(*names, engine: engine, options: options)
      else
        register_fixer_upper(names, engine, options)
      end
    end

    def register_tilt(*names, engine:, options: {})
      engine_bridge =
        TiltTemplateClassBridge.new(engine, options)

      names.each do |name|
        register_single(name, engine_bridge)
      end
    end

    def engine?(engine)
      @engines.key?(engine.to_s)
    end

    def [](engine_name)
      @engines[engine_name.to_s]
    end

    private

    def definitely_like_tilt_template?(engine)
      engine < Tilt::Template
    end

    def engine_class_name(engine)
      if engine.is_a?(TiltTemplateClassBridge)
        engine.tilt_engine_class.name
      else
        engine.name
      end
    end

    def register_fixer_upper(names, engine, options)
      if options.any?
        raise Error::EngineDoesntAcceptOptions, \
          "Only Tilt templates can accept options"
      end

      names.each do |name|
        register_single(name, engine)
      end
    end

    def register_single(name, engine)
      if engine?(name)
        existing_engine = self[name]

        raise Error::MultipleEnginesForOneName, \
          "Trying to register `#{engine_class_name(engine)}` " \
          "to the name `#{name}`, " \
          "but `#{engine_class_name(existing_engine)}` is already registered."
      end

      @engines[name.to_s] = engine
    end
  end
end
