class FixerUpper
  module Engine
    class Erb
      def call(text, scope:, &block)
        scope_binding = scope.instance_eval { binding }

        ::ERB.new(text).result(scope_binding)
      end
    end
  end
end
