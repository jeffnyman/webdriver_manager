require "nokogiri"

module WebDriverManager
  class ChromeDriver
    extend Support

    class << self
      def driver_name
        os_platform == "win" ? "chromedriver.exe" : "chromedriver"
      end

      def driver_base_url
        "http://chromedriver.storage.googleapis.com"
      end

      def driver_binary_list
        @binaries ||= begin
          files = process_binary_files
          process_binary_versions(files)
        end
      end

      def process_binary_files
        resource = Nokogiri::XML.parse(get(driver_base_url))
        files = resource.css("Contents Key").collect(&:text)
        files.select! { |file| file.include?(os_platform) }
      end

      def process_binary_versions(files)
        binary_list = files.each_with_object({}) do |file, binary|
          version = normalize(file[%r{^[^\/]+}])
          binary[version] = "#{driver_base_url}/#{file}"
        end

        WebDriverManager.logger.debug(
          "Versions now located at driver URL: #{binary_list.keys}"
        )

        binary_list
      end

      # This method makes sure that versions are stored with the same
      # style. For example, 2.10 will be stored exactly as that. But 2.9
      # will be stored as 2.09.
      def normalize(string)
        string.size == 3 ? string.gsub('.', '.0').to_f : string.to_f
      end
    end
  end
end
