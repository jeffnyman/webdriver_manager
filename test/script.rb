$LOAD_PATH << "./lib"
require "webdriver_manager"

WebDriverManager.logger.level = :debug

require "watir"

browser = Watir::Browser.new :firefox

browser.quit()
