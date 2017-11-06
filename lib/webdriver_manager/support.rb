module WebDriverManager
  module Support
    def provision
      remove_binary
      puts driver_binary_list
      puts driver_binary
    end

    def remove_binary
      WebDriverManager.logger.debug("Deleting #{driver_binary}")
      FileUtils.rm_f(driver_binary)
    end

    protected

    def get(url)
      response = Net::HTTP.get_response(URI(url))

      case response
        when Net::HTTPSuccess then response.body
      end
    end

    private

    # This method gets the full driver binary, by getting the driver
    # repository, which it determines from this module, coupled with the
    # name of the driver, which is gathered from the driver-specific class.
    def driver_binary
      File.join(driver_repo, driver_name)
    end

    def driver_repo
      File.expand_path(File.join(ENV['HOME'], ".webdrivers")).tap do |dir|
        FileUtils.mkdir_p(dir)
      end
    end

    def os_platform
      cfg = RbConfig::CONFIG
      case cfg['host_os']
        when /linux/
          cfg['host_cpu'] =~ /x86_64|amd64/ ? "linux64" : "linux32"
        when /darwin/
          "mac"
        else
          "win"
      end
    end
  end
end
