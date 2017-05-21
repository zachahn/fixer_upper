class FixerUpper
  class Error < StandardError
    class EngineNotFound < FixerUpper::Error
    end
  end
end
