class FixerUpper
  class Contractor
    def initialize(registry, options)
      @registry = registry
      @options = options
    end

    def call(text:, engines:, options:, filepath:, block:, bang:)
      engines.reduce(text) do |memo, engine_name|
        engine = find_engine(engine_name, bang)

        if engine.nil?
          next memo
        end

        parameters = parameters_for(engine)
        merged_options =
          options_for_engine(engine_name, options, parameters, filepath)

        engine_invoke(engine, memo, merged_options, parameters, block)
      end
    end

    private

    def find_engine(engine_name, bang)
      if bang
        engine_or_raise(engine_name)
      else
        engine_or_nil(engine_name)
      end
    end

    def engine_invoke(engine, text, options, parameters, block)
      if options.any? && parameters.count >= 2
        engine.call(text, **options, &block)
      else
        engine.call(text, &block)
      end
    end

    def parameters_for(engine)
      if engine.respond_to?(:parameters)
        engine.parameters
      else
        engine.method(:call).parameters
      end
    end

    def options_for_engine(engine_name, local_options, parameters, filepath)
      default_options = @options[engine_name] || {}
      specific_options = local_options[engine_name.to_sym] || {}

      merged_options = default_options.merge(specific_options)

      if parameters.include?([:keyreq, :_filepath_])
        merged_options[:_filepath_] = filepath
      end

      merged_options
    end

    def engine_or_nil(engine_name)
      @registry[engine_name]
    end

    def engine_or_raise(engine_name)
      found_engine = @registry[engine_name]

      if found_engine
        found_engine
      else
        raise Error::EngineNotFound, "unknown engine: `#{engine_name}`"
      end
    end
  end
end
