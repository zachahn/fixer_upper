class FixerUpper
  module Engine
    class Erb
      def call(text, scope:, _filepath_:, &block)
        scope_binding = scope.instance_eval { binding }

        erb = ::ERB.new(text)
        erb.filename = _filepath_
        erb.result(scope_binding)
      end
    end
  end
end
