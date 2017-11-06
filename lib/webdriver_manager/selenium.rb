require "selenium-webdriver"

require "webdriver_manager/support"
require "webdriver_manager/drivers/driver_chrome"

module Selenium
  module WebDriver
    module Chrome
      @driver_path ||= WebDriverManager::ChromeDriver.provision
    end
  end
end
