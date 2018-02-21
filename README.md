# WebDriver Manager

[![Gem Version](https://badge.fury.io/rb/webdriver_manager.svg)](http://badge.fury.io/rb/webdriver_manager)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jeffnyman/webdriver_manager/blob/master/LICENSE.txt)

[![Dependency Status](https://gemnasium.com/jeffnyman/webdriver_manager.png)](https://gemnasium.com/jeffnyman/webdriver_manager)

The goal of WebDriver Manager is to allow automated testing solutions an ability to have WebDriver binary drivers downloaded automatically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'webdriver_manager'
```

And then include it in your bundle:

    $ bundle

You can also install WebDriver Manager just as you would any other gem:

    $ gem install webdriver_manager

## Usage

### Basic Usage

Here is an example script:

```ruby
require "webdriver_manager"
require "watir"

browser = Watir::Browser.new :firefox

browser.quit()
```

All you have to do is include `webdriver_manager`. Once it's included, the gem provides hooks into the operation of Selenium WebDriver. When Watir, in this case, is used to instantiate a new Firefox browser, this gem kicks in and makes sure that `geckodriver` (or `geckodriver.exe` on Windows) is available. If the driver binary is not available, it will be downloaded for you.

All driver binaries are placed in a `.webdrivers` directory within the relevant directory referred to by the `HOME` environment variable for your operating system.

### Browser Drivers Supported

Currently WebDriver Manager supports only Chrome (chromedriver) and Firefox (geckodriver). I will be adding support for other browsers, such as Internet Explorer and Microsoft Edge, once I'm certain I have a fully reliable means of getting the drivers.

I do have mechanisms in place to support IE and Edge but they work sporadically, at best.

### Logging

You can enable logging with WebDriver Manager with a command like this:

```ruby
WebDriverManager.logger.level = :debug
```

There are debug statements in the code base that will show you what's happening as WebDriver Manager operates. But you are free to add your own messages as well. For example, you could set the logging level to `info` and then add your own messages:

```ruby
WebDriverManager.logger.level = :info
WebDriverManager.logger.info("Some Information")
```

You can also set the logging output to a file:

```ruby
WebDriverManager.logger.output = 'webdriver_manager.log'
```

### How It Works

WebDriver Manager works by providing an additional implementation to the `@driver_path` variable that Selenium uses when establishing an instance of a driver. For example, the [Chrome](https://github.com/SeleniumHQ/selenium/blob/master/rb/lib/selenium/webdriver/chrome.rb) implementation simply takes in a path for the driver. This gem overrides that with its own specific functionality for providing a standard path and making sure the relevant binaries are on that path and downloading them if not.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec:all` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jeffnyman/webdriver_manager](https://github.com/jeffnyman/webdriver_manager). The testing ecosystem of Ruby is very large and this project is intended to be a welcoming arena for collaboration on yet another testing tool. As such, contributors are very much welcome but are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

To contribute to WebDriver Manager:

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create your feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Author

* [Jeff Nyman](http://testerstories.com)

## Credits

There is a good Python project called [webdriver_manager](https://github.com/SergeyPirogov/webdriver_manager) as well as a Java project [WebDriverManager](https://github.com/bonigarcia/webdrivermanager). This is my attempt to provide the same functionality in a Ruby context. I'm relying, as inspiration, on Titus Fortner's [webdrivers](https://github.com/titusfortner/webdrivers) project while trying to update some aspects of, including a cleanup of the overall code base.

## License

WebDriver Manager is distributed under the [MIT](http://www.opensource.org/licenses/MIT) license.
See the [LICENSE](https://github.com/jeffnyman/webdriver_manager/blob/master/LICENSE.txt) file for details.
