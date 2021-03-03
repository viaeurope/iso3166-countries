# frozen_string_literal: true

module ISO3166
  class XMLData
    @@semaphore = Mutex.new
    @@data = nil

    class << self
      def reset!
        @@data = nil
      end

      def reload!
        return if @@data

        @@semaphore.synchronize do
          @@data = File.open(ISO3166::Countries.data_path) { |f| Nokogiri::XML(f) }
        end
      end

      def find(code)
        reload!
        @@data.at_xpath("//country[@id='#{code}']")
      end

      def find_by_alpha3(code)
        reload!
        @@data.at_xpath("//country[alpha-3-code[text()='#{code}']]")
      end

      def all_names_with_codes
        reload!
        @@data.xpath("//country[status[text()='officially-assigned']]").map do |xml_node|
          [
            xml_node.at_xpath("./short-name[@lang3code='eng']").text,
            xml_node.at_xpath("./alpha-2-code").text
          ]
        end
      end
    end
  end
end
