require "spec_helper"

RSpec.describe MessengerPlatform do

  describe "#setup" do

    it "sets the configured values" do
      MessengerPlatform.setup do |c|
        c.verify_token = "TESTER VERIFY TOKEN"
        c.access_token = "TESTER ACCESS TOKEN"
        c.processor_class = Complex
        c.processor_method = :real?
      end

      expect(MessengerPlatform.verify_token).to eq "TESTER VERIFY TOKEN"
      expect(MessengerPlatform.access_token).to eq "TESTER ACCESS TOKEN"
      expect(MessengerPlatform.processor_class).to be Complex
      expect(MessengerPlatform.processor_method).to be :real?
    end

  end

  describe "#facebook_api_base_url" do
    before do
      MessengerPlatform.setup do |c|
        c.access_token = "supah hot fire"
      end
    end
    let(:facebook_url) { MessengerPlatform.facebook_api_base_url("tester_api_method") }

    it "returns url containing facebook bits" do
      expect(facebook_url).to match(/.*graph\.facebook\.com/)
    end

    it "returns url containing the api method url was requested for" do
      expect(facebook_url).to include("tester_api_method")
    end

    it "returns url containing the access token" do
      expect(facebook_url).to include("supah+hot+fire")
    end

  end

end
