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

    def alpha2
      code.to_s
    end

    def alpha3
      @_alpha3 ||= data.at_xpath("./alpha-3-code").text
    end

    def name
      @_name ||= data.at_xpath("./short-name[@lang3code='eng']").text
    end

    def number
      @_number ||= data.at_xpath("./numeric-code").text
    end
  end
end
