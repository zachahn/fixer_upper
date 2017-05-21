class FixerUpper
  class Renovation
    def initialize(registry)
      @registry = registry
    end

    def call(filepath, contents)
      text = file_contents(filepath, contents)

      extensions(filepath).reverse.reduce(text) do |memo, extension|
        engine = @registry[extension]

        if engine
          engine.call(memo)
        else
          memo
        end
      end
    end

    private

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
