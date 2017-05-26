class FixerUpper
  module Engine
    class Erb
      def call(text, scope:, filepath:, &block)
        scope_binding = scope.instance_eval { binding }

        erb = ::ERB.new(text)
        erb.filename = filepath
        erb.result(scope_binding)
      end
    end
  end
end
