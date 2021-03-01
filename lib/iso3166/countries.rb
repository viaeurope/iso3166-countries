# frozen_string_literal: true

require "nokogiri"
require_relative "countries/version"
require_relative "data"
require_relative "country"

module ISO3166
  module Countries
    class << self
      attr_writer :data_path

      def data_path
        @data_path ||
          File.join(__dir__, "..", "..", "data", "sample.xml")
      end
    end
  end
end
