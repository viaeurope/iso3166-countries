# frozen_string_literal: true

require "nokogiri"
require_relative "countries/version"
require_relative "data"
require_relative "country"

module ISO3166
  module Countries
    class << self
      def data_path
        @data_path ||
          File.join(__dir__, "..", "..", "data", "sample.xml")
      end

      def data_path=(path)
        ISO3166::Data.reset!
        @data_path = path
      end
    end
  end
end
