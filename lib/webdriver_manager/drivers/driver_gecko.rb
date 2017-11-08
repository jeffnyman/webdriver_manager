require "nokogiri"

module WebDriverManager
  class GeckoDriver
    extend Support

    class << self
      def current_binary
        WebDriverManager.logger.debug("Checking Current Driver Version")
        return nil unless driver_is_downloaded?
        binary_version = `#{driver_binary} --version`
        WebDriverManager.logger.debug(
          "Current version of #{driver_binary} is #{binary_version}"
        )
        normalize(binary_version.match(/geckodriver (\d+\.\d+\.\d+)/)[1])
      end

      def driver_name
        os_platform == "win" ? "geckodriver.exe" : "geckodriver"
      end

      def driver_base_url
        "https://github.com/mozilla/geckodriver/releases"
      end

      def driver_binary_list
        unless driver_url_is_reachable?
          raise StandardError, "Unable to Access the Driver URL"
        end

        @binaries ||= begin
          files = process_binary_files
          process_binary_versions(files)
        end
      end

      def process_binary_files
        resource = Nokogiri::XML.parse(get(driver_base_url))
        files = resource.css(".release-downloads a")
                        .collect { |file| file["href"] }
        files.reject! { |file| file.include?('archive') }
        files.select! { |file| file.include?(os_platform) }
      end

      def process_binary_versions(files)
        binary_list = files.each_with_object({}) do |file, binary|
          version = normalize(file[/v(\d+\.\d+\.\d+)/, 1])
          binary[version] = "https://github.com#{file}"
        end

        WebDriverManager.logger.debug(
          "Versions Located at Driver URL: #{binary_list.keys}"
        )

        binary_list
      end

      def normalize(string)
        string.match(/(\d+)\.(\d+\.\d+)/)
              .to_a
              .map { |v| v.tr('.', '') }[1..-1].join('.').to_f
      end
    end
  end
end
