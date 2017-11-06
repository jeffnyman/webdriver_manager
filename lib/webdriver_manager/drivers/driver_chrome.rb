module WebDriverManager
  class ChromeDriver
    extend Support

    class << self
      def driver_name
        os_platform == "win" ? "chromedriver.exe" : "chromedriver"
      end
    end
  end
end
