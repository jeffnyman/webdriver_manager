require "nokogiri"

module WebDriverManager
  class IEDriver
    extend Support

    class << self
      def current_binary
        WebDriverManager.logger.debug("Checking Current Driver Version")
        return nil unless driver_is_downloaded?
        binary_version = `#{driver_binary} --version`
        WebDriverManager.logger.debug(
          "Current version of #{driver_binary} is #{binary_version}"
        )
        normalize(
          binary_version.match(/IEDriverServer.exe (\d\.\d+\.\d*\.\d*)/)[1]
        )
      end

      def normalize(string)
        string.to_f
      end

      def driver_name
        "IEDriverServer.exe"
      end

      def driver_base_url
        "http://selenium-release.storage.googleapis.com/"
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
        files = resource.css("Key").collect(&:text)
        files.select! { |file| file.include?("IEDriverServer_Win32") }
      end

      def process_binary_versions(files)
        binary_list = files.each_with_object({}) do |file, binary|
          version = normalize(file[%r{^[^\/]+}])
          binary[version] = "#{driver_base_url}/#{file}"
        end

        WebDriverManager.logger.debug(
          "Versions Located at Driver URL: #{binary_list.keys}"
        )

        binary_list
      end
    end
  end
end
