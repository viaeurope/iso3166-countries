# frozen_string_literal: true

module ISO3166
  class Data
    @@semaphore = Mutex.new
    @@xml_data = nil

    class << self
      def reset!
        @@xml_data = nil
      end

      def reload!
        return if @@xml_data

        @@semaphore.synchronize do
          @@xml_data = File.open(ISO3166::Countries.data_path) { |f| Nokogiri::XML(f) }
        end
      end

      def find(code)
        reload!
        @@xml_data.at_xpath("//country[@id='#{code}']")
      end
    end
  end
end
