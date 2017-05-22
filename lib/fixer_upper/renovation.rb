class FixerUpper
  class Renovation
    def initialize(registry, options)
      @registry = registry
      @options = options
    end

    def renovate(filepath, contents, bang:)
      text = file_contents(filepath, contents)

      diy(text, *extensions(filepath).reverse, bang: bang)
    end

    def diy(text, *engines, bang:)
      mapped_engines = map_engines(engines, bang: bang).compact

      mapped_engines.reduce(text) do |memo, engine|
        default_options = @options[engine]

        if default_options && engine.method(:call).parameters.count >= 2
          engine.call(memo, **default_options)
        else
          engine.call(memo)
        end
      end
    end

    private

    def map_engines(engines, bang:)
      engines.map do |engine_request|
        if engine_request.respond_to?(:call)
          next engine_request
        end

        if bang
          engine_or_raise(engine_request)
        else
          engine_or_nil(engine_request)
        end
      end
    end

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
