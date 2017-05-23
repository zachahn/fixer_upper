class FixerUpper
  module Engine
    class Scss
      def call(text, _filepath_:, **options)
        options = options.merge(syntax: :scss, filename: _filepath_)

        engine = ::Sass::Engine.new(text, **options)
        engine.render
      end
    end
  end
end
