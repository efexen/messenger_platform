require "spec_helper"

RSpec.describe MessengerPlatform::InboundMessage do

  context "no attachments" do
    let(:message) { MessengerPlatform::InboundMessage.new({ sender: { id: "12" }, recipient: { id: "34" } }) }

    describe ".attachments" do
      it "returns empty array" do
        expect(message.attachments).to eq []
      end
    end

    describe ".attachments?" do
      it "returns false" do
        expect(message.attachments?).to be false
      end
    end
  end

  context "with attachments" do
    let(:message) do
      MessengerPlatform::InboundMessage.new({
        sender: { id: "12" },
        recipient: { id: "34" },
        message: {
          attachments: [{
            type: "image",
            payload: { url: "bunnies.gifpengs" }
          }]
        }
      })
    end

    describe ".attachments" do
      it "returns array of attachments" do
        expect(message.attachments.first).to be_a(MessengerPlatform::Attachment)
      end
    end

    describe ".attachments?" do
      it "returns true" do
        expect(message.attachments?).to be true
      end
    end

  end

end
