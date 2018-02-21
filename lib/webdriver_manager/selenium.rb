require "selenium-webdriver"

require "webdriver_manager/support"
require "webdriver_manager/drivers/driver_chrome"
require "webdriver_manager/drivers/driver_gecko"
require "webdriver_manager/drivers/driver_ie"
require "webdriver_manager/drivers/driver_ms"

module Selenium
  module WebDriver
    module Chrome
      def self.driver_path
        @driver_path ||= WebDriverManager::ChromeDriver.provision
      end
    end

    module Firefox
      def self.driver_path
        @driver_path ||= WebDriverManager::GeckoDriver.provision
      end
    end

    module IE
      def self.driver_path
        @driver_path ||= WebDriverManager::IEDriver.provision
      end
    end

    module Edge
      def self.driver_path
        @driver_path ||= WebDriverManager::MSDriver.provision
      end
    end
  end
end
