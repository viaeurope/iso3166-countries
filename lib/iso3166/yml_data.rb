# frozen_string_literal: true

module ISO3166
  class YMLData
    @@semaphore = Mutex.new
    @@data = nil

    class << self
      def reset!
        @@data = nil
      end

      def reload!
        return if @@data

        @@semaphore.synchronize do
          @@data = YAML.load_file(ISO3166::Countries.yml_data_path)
        end
      end

      def find(code)
        reload!
        @@data[code.to_s]
      end
    end
  end
end
