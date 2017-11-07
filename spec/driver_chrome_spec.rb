RSpec.describe WebDriverManager::ChromeDriver do
  let(:chromedriver) { WebDriverManager::ChromeDriver }

  context "when online" do
    it "will find the latest version" do
      expect(chromedriver.latest_binary).to be > 2.30
      expect(chromedriver.latest_binary).to be < 2.9
    end

    it "will normalize chromedriver versions before 2.10" do
      expect(chromedriver.send :normalize, '2.9').to eq 2.09
    end

    it "will download the latest version by default" do
      chromedriver.remove_binary
      chromedriver.provision_driver
      expect(chromedriver.current_binary).to eq chromedriver.latest_binary
    end

    it "will download a specified version" do
      chromedriver.remove_binary
      chromedriver.provision_driver(2.29)
      expect(chromedriver.current_binary).to eq 2.29
    end

    it "will remove the chromedriver" do
      chromedriver.remove_binary
      expect(chromedriver.current_binary).to be_nil
    end
  end

  context "when offline" do
    before { allow(chromedriver).to receive(:driver_url_is_reachable?).and_return(false) }

    it "will raise an exception for finding latest version" do
      expect { chromedriver.latest_binary }.to raise_error(StandardError, "Unable to Access the Driver URL")
    end

    it "will raise an exception when downloading" do
      expect { chromedriver.provision_driver }.to raise_error(StandardError, "Unable to Access the Driver URL")
    end
  end
end
