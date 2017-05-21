class FixerUpper
  module Engine
    class Cmark
      def call(content)
        CommonMarker.render_html(content)
      end
    end
  end
end
