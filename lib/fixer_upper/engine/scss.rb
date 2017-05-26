class FixerUpper
  module Engine
    class Scss
      def call(text, filepath:, **options)
        options = options.merge(syntax: :scss, filename: filepath)

        engine = ::Sass::Engine.new(text, **options)
        engine.render
      end
    end
  end
end
