# frozen_string_literal: true

require "nokogiri"
require "yaml"
require_relative "countries/version"
require_relative "xml_data"
require_relative "yml_data"
require_relative "country"

module ISO3166
  module Countries
    class << self
      def data_path
        @data_path ||
          File.join(__dir__, "..", "..", "data", "sample.xml")
      end

      def yml_data_path
        File.join(__dir__, "..", "..", "data", "extended.yml")
      end

      def data_path=(path)
        ISO3166::XMLData.reset!
        @data_path = path
      end
    end
  end
end
