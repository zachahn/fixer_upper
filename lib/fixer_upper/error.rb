class FixerUpper
  class Error < StandardError
    class MultipleEnginesForOneName < Error
    end

    class EngineDoesntAcceptOptions < Error
    end
  end
end
