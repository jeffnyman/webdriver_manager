require "webdriver_manager/version"
require "webdriver_manager/logger"
require "webdriver_manager/selenium"

module WebDriverManager
  class << self
    def logger
      @logger ||= WebDriverManager::Logger.new
    end
  end
end
