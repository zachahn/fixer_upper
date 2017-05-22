class FixerUpper
  class Renovation
    def initialize(registry, options)
      @registry = registry
      @options = options
    end

    def renovate(filepath:, text: nil, options:, bang:)
      contents = file_contents(filepath, text)

      diy(
        text: contents,
        engines: extensions(filepath).reverse,
        options: options,
        bang: bang
      )
    end

    def diy(text:, engines:, options:, bang:)
      engines.reduce(text) do |memo, engine_name|
        engine = find_engine(engine_name, bang)

        merged_options = options_for_engine(engine_name, options)

        if merged_options.any? && engine.method(:call).parameters.count >= 2
          engine.call(memo, **merged_options)
        else
          engine.call(memo)
        end
      end
    end

    private

    def options_for_engine(engine_name, local_options)
      default_options = @options[engine_name] || {}
      specific_options = local_options[engine_name.to_sym] || {}

      default_options.merge(specific_options)
    end

    def find_engine(engine_name, bang)
      if bang
        engine_or_raise(engine_name)
      else
        engine_or_nil(engine_name)
      end
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

    def file_contents(filepath, contents)
      if contents
        contents
      else
        File.read(filepath)
      end
    end

    def extensions(filepath)
      filename = File.basename(filepath)
      divided_by_dots = filename.split(".")

      divided_by_dots[1..-1]
    end
  end
end
