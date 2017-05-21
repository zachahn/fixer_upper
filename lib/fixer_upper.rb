require "fixer_upper/version"

class FixerUpper
  def initialize
    @engine_registry = {}
  end

  def []=(key, engine)
    @engine_registry[key] = engine
  end

  def renovate(filepath, contents = nil)
    string = file_contents(filepath, contents)

    extensions(filepath).reverse.reduce(string) do |memo, extension|
      engine = @engine_registry[extension]

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
