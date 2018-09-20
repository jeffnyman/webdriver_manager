module WebDriverManager
  module Support
    def provision
      unless driver_url_is_reachable?
        return current_binary.nil? ? nil : driver_binary
      end

      return driver_binary if current_binary == latest_binary

      remove_binary && provision_driver
    end

    def provision_driver(version = nil)
      url, filename = driver_filename(version)
      Dir.mkdir(driver_repo) unless File.exist?(driver_repo)

      Dir.chdir(driver_repo) do
        download_driver(filename, url)
        decompress_driver(filename)
      end

      set_driver_permissions
      driver_binary
    end

    def remove_binary
      WebDriverManager.logger.debug("Deleting #{driver_binary}")
      FileUtils.rm_f(driver_binary)
    end

    def latest_binary
      driver_binary_list.keys.max
    end

    protected

    def get(url)
      response = Net::HTTP.get_response(URI(url))

      case response
        when Net::HTTPSuccess then response.body
        when Net::HTTPRedirection
          location = response['location']
          WebDriverManager.logger.debug("Redirected to #{location}")
          get(location)
      end
    end

    private

    def download_driver(filename, url)
      FileUtils.rm_f(filename)

      open(filename, "wb") do |file|
        file.print(get(url))
      end

      raise "Unable to download #{url}" unless File.exist?(filename)
      WebDriverManager.logger.debug("Successfully downloaded #{filename}")
    end

    def decompress_driver(filename)
      dcf = decompress_file(filename)
      WebDriverManager.logger.debug("Decompression Complete")

      if dcf
        WebDriverManager.logger.debug("Deleting #{filename}")
        FileUtils.rm_f(filename)
      end

      return if File.exist?(driver_binary)
      raise "Unable to decompress #{filename} to get #{driver_binary}"
    end

    def decompress_file(filename)
      case filename
        when /tar\.gz$/
          WebDriverManager.logger.debug("Decompressing tar")
          untargz_file(filename)
        when /\.zip$/
          WebDriverManager.logger.debug("Decompressing zip")
          unzip_file(filename)
      end
    end

    def unzip_file(filename)
      require "zip"
      Zip::File.open("#{Dir.pwd}/#{filename}") do |zip_file|
        zip_file.each do |f|
          @top_path ||= f.name
          f_path = File.join(Dir.pwd, f.name)

          remove_binary

          zip_file.extract(f, f_path)
        end
      end
      @top_path
    end

    def untargz_file(filename)
      require "rubygems/package"
      tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(filename))
      file = File.open(driver_name, "w+b")
      tar_extract.each { |entry| file << entry.read }
      file.close
      File.basename(file)
    end

    def set_driver_permissions
      FileUtils.chmod("ugo+rx", driver_binary)
      WebDriverManager.logger.debug(
        "Completed download and processing of #{driver_binary}"
      )
    end

    def driver_filename(version)
      url = driver_download_url(version)
      filename = File.basename(url)
      [url, filename]
    end

    def driver_url_is_reachable?
      get(driver_base_url)
      WebDriverManager.logger.debug("Driver URL Available: #{driver_base_url}")
      true
    rescue StandardError
      WebDriverManager.logger.debug(
        "Driver URL Not Available: #{driver_base_url}"
      )
      false
    end

    def driver_is_downloaded?
      result = File.exist?(driver_binary)
      WebDriverManager.logger.debug("Driver Already Downloaded: #{result}")
      result
    end

    def driver_download_url(version)
      driver_binary_list[version || latest_binary]
    end

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
