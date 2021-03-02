# frozen_string_literal: true

module ISO3166
  class Country
    class TooManyArguments < StandardError; end

    def self.new(code, xml_node: nil)
      return super(xml_node) if xml_node

      if (xml_node = ISO3166::XMLData.find(code))
        super(xml_node)
      end
    end

    def self.find_by(alpha2: nil, alpha3: nil)
      raise TooManyArguments, "submit either alpha2 or alpha3" if alpha2 && alpha3

      if alpha2
        new(alpha2)
      elsif alpha3 && (xml_node = ISO3166::XMLData.find_by_alpha3(alpha3))
        new(nil, xml_node: xml_node)
      end
    end

    attr_reader :xml_node

    def initialize(xml_node)
      @xml_node = xml_node
    end

    def alpha2
      @_alpha2 ||= xml_node.at_xpath("./alpha-2-code").text
    end

    def alpha3
      @_alpha3 ||= xml_node.at_xpath("./alpha-3-code").text
    end

    def name
      @_name ||= xml_node.at_xpath("./short-name[@lang3code='eng']").text
    end
    alias_method :translation, :name

    def number
      @_number ||= xml_node.at_xpath("./numeric-code").text
    end

    def in_eu?
      !!yml_data["eu_member"]
    end

    def yml_data
      @_yml_data ||= ISO3166::YMLData.find(alpha2) || {}
    end

    def ==(other)
      other.respond_to?(:alpha2) && other.alpha2 == alpha2
    end
    alias_method :eql?, :==
  end
end
