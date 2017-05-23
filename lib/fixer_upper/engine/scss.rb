class FixerUpper
  module Engine
    class Scss
      def call(text, **options)
        options = options.merge(syntax: :scss)

        engine = ::Sass::Engine.new(text, **options)
        engine.render
      end
    end
  end
end
