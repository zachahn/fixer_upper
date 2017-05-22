module TestCaseEngines
  class Identity
    def call(text)
      text
    end
  end

  class Call
    def call(text, method:)
      text.public_send(method)
    end
  end

  class Rotate
    def initialize(amount)
      @amount = amount
    end

    def call(text)
      n = "A".ord + @amount - 1
      n_ = "A".ord + @amount
      split = "#{n_.chr}-ZA-#{n.chr}"

      text.tr("A-Za-z", split.upcase + split.downcase)
    end
  end

  class Shout
    def call(text)
      text.upcase
    end
  end
end
