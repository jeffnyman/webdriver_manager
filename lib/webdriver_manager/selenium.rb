require "selenium-webdriver"

require "webdriver_manager/support"
require "webdriver_manager/drivers/driver_chrome"

module Selenium
  module WebDriver
    module Chrome
      def self.driver_path
        @driver_path ||= WebDriverManager::ChromeDriver.provision
      end
    end
  end
end
