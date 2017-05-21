class FixerUpper
  module Engine
    class Erb
      def initialize(scope)
        @scope = scope
      end

      def call(content)
        scope_binding = @scope.instance_eval { binding }

        ::ERB.new(content).result(scope_binding)
      end
    end
  end
end
