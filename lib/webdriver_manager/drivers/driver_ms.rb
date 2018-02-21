module WebDriverManager
  class MSDriver
    extend Support

    class << self
      def current_binary
        WebDriverManager.logger.debug("Checking Current Driver Version")
        windows_version = `#{ver}`
        WebDriverManager.logger.debug(
          "Current version of Windows is #{windows_version}"
        )
        windows_version[/\d+\.\d+\.\d+/][/[^\.]\d+$/]
      end

      def driver_name
        "MicrosoftWebDriver.exe"
      end

      def driver_base_url
        # https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/#downloads
        "https://www.microsoft.com/en-us/download"
      end

      def driver_binary_list
        case current_binary.to_i
          when 10240
            WebDriverManager.logger.debug("Downloading 10240 MS WebDriver.")
            build = "8D0D08CF-790D-4586-B726-C6469A9ED49C/MicrosoftWebDriver.msi"
            "https://download.microsoft.com/download/8/D/0/#{build}"
          when 10586
            WebDriverManager.logger.debug("Downloading 10586 MS WebDriver.")
            build = "C07EBF21-5305-4EC8-83B1-A6FCC8F93F45/MicrosoftWebDriver.msi"
            "https://download.microsoft.com/download/C/0/7/#{build}"
          when 14393
            WebDriverManager.logger.debug("Downloading 14393 MS WebDriver.")
            build = "32D3E464-F2EF-490F-841B-05D53C848D15/MicrosoftWebDriver.exe"
            "https://download.microsoft.com/download/3/2/D/#{build}"
          when 15063
            WebDriverManager.logger.debug("Downloading 15063 MS WebDriver.")
            build = "342316D7-EBE0-4F10-ABA2-AE8E0CDF36DD/MicrosoftWebDriver.exe"
            "https://download.microsoft.com/download/3/4/2/#{build}"
          when "16299"
            WebDriverManager.logger.debug("Downloading 16299 MS WebDriver.")
            build = "D417998A-58EE-4EFE-A7CC-39EF9E020768/MicrosoftWebDriver.exe"
            "https://download.microsoft.com/download/D/4/1/#{build}"
          else
            WebDriverManager.logger.debug("Downloading latest Insider driver.")
            build = "14156DA0-D40F-460A-B14D-1B264CA081A5/MicrosoftWebDriver.exe"
            "https://download.microsoft.com/download/1/4/1/#{build}"
        end
      end
    end
  end
end
