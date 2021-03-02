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
    end
  end
end
