$LOAD_PATH << "./lib"
require "webdriver_manager"

WebDriverManager.logger.level = :info

WebDriverManager.logger.info("Testing Info")
WebDriverManager.logger.debug("Testing Debug")
