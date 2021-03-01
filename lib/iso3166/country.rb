# frozen_string_literal: true

module ISO3166
  class Country
    def self.new(code)
      if (data = ISO3166::Data.find(code))
        super(code, data)
      end
    end

    attr_reader :code, :data

    def initialize(code, data)
      @code, @data = code, data
    end
  end
end
