class FixerUpper
  class Renovation
    def initialize(registry, options)
      @registry = registry
      @options = options
    end

    def renovate(filepath:, text: nil, options:, block: nil, bang:)
      contents = file_contents(filepath, text)

      diy(
        text: contents,
        engines: extensions(filepath).reverse,
        options: options,
        filepath: filepath,
        block: block,
        bang: bang
      )
    end

    def diy(text:, engines:, options:, filepath: nil, block: nil, bang:)
      contractor = Contractor.new(@registry, @options)
      contractor.call(
        text: text,
        engines: engines,
        options: options,
        filepath: filepath,
        block: block,
        bang: bang
      )
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
