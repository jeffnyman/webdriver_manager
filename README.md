# WebDriver Manager

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
