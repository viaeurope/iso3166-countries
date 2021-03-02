# frozen_string_literal: true

module ISO3166
  class Country
    def self.new(code)
      if (xml_node = ISO3166::XMLData.find(code))
        super(code, xml_node)
      end
    end

    attr_reader :code, :xml_node

    def initialize(code, xml_node)
      @code, @xml_node = code, xml_node
    end

    def alpha2
      code.to_s
    end

    def alpha3
      @_alpha3 ||= xml_node.at_xpath("./alpha-3-code").text
    end

    def name
      @_name ||= xml_node.at_xpath("./short-name[@lang3code='eng']").text
    end

    def number
      @_number ||= xml_node.at_xpath("./numeric-code").text
    end

    def in_eu?
      !!yml_data["eu_member"]
    end

    def yml_data
      @_yml_data ||= ISO3166::YMLData.find(code) || {}
    end
  end
end
