require "forwardable"
require "logger"

module WebDriverManager
  class Logger
    extend Forwardable
    include ::Logger::Severity

    def_delegators :@logger,
      :debug, :debug?,
      :info, :info?,
      :warn, :warn?,
      :error, :error?,
      :fatal, :fatal?,
      :level

    def initialize
      @logger = create_logger($stdout)
    end

    def level=(severity)
      case severity.to_s.downcase
        when 'debug'.freeze then @logger.level = DEBUG
        when 'info'.freeze then @logger.level = INFO
        when 'warn'.freeze then @logger.level = WARN
        when 'error'.freeze then @logger.level = ERROR
        else
          raise ArgumentError, "invalid log level: #{severity}"
      end
    end

    def output=(io)
      if @logger.respond_to?(:reopen)
        @logger.reopen(io)
      else
        @logger = create_logger(io)
      end
    end

    private

    def create_logger(output)
      logger = ::Logger.new(output)
      logger.progname = 'WebDriver Manager'
      logger.level = ($DEBUG ? DEBUG : WARN)

      logger.formatter = proc do |severity, time, progname, msg|
        "#{time.strftime('%F %T')} #{severity} #{progname} #{msg}\n"
      end

      logger
    end
  end
end
