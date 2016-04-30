require "spec_helper"
require "support/outbound_message_specs"

RSpec.describe MessengerPlatform::ImageMessage do
  let(:recipient) { MessengerPlatform::Contact.new({ id: 1 }) }

  it_should_behave_like "an outbound message"

  describe ".serialize" do
    let(:message) { described_class.new(recipient, "bunnies.png") }

    it "returns hash containing attachment type of image" do
      expect(message.serialize[:message][:attachment][:type]).to eq "image"
    end

    it "returns hash containing the image url" do
      expect(message.serialize[:message][:attachment][:payload][:url]).to eq "bunnies.png"
    end

  end
end
