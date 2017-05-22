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
        engine =
          if bang
            engine_or_raise(engine_name)
          else
            engine_or_nil(engine_name)
          end

        default_options = @options[engine_name] || {}
        specific_options = options[engine_name.to_sym] || {}
        merged_options = default_options.merge(specific_options)

        if merged_options.any? && engine.method(:call).parameters.count >= 2
          engine.call(memo, **merged_options)
        else
          engine.call(memo)
        end
      end
    end

    private

    def engine_or_nil(engine_name)
      @registry[engine_name]
    end

    def engine_or_raise(engine_name)
      found_engine = @registry[engine_name]

      if found_engine
        file_contents
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
