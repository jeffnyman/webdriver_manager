require "webdriver_manager/version"
require "webdriver_manager/logger"

module WebDriverManager
  class << self
    def logger
      @logger ||= WebDriverManager::Logger.new
    end
  end
end
