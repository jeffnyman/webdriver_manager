$LOAD_PATH << "./lib"
require "webdriver_manager"

WebDriverManager.logger.level = :debug

require "watir"

Watir::Browser.new
