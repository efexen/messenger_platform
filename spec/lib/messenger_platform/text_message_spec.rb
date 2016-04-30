require "spec_helper"
require "support/outbound_message_specs"

RSpec.describe MessengerPlatform::TextMessage do
  let(:recipient) { MessengerPlatform::Contact.new({ id: 1 }) }

  it_should_behave_like "an outbound message"

  describe ".serialize" do
    let(:message) { described_class.new(recipient, "TEST MESSAGE THING") }

    it "returns hash containing the message" do
      expect(message.serialize[:message][:text]).to eq "TEST MESSAGE THING"
    end

    context "overlength message" do
      let(:message) { described_class.new(recipient, "Chase the pig around the house give attitude slap owner's face at 5am until human fills food dish scratch at the door then walk away or chase red laser dot cough furball but stick butt in face. Sleep on dog bed, force dog to sleep on floor cat snacks touch water with paw then recoil in horror throwup on your pillow use lap as chair. Get video posted to internet for chasing red dot.") }

      it "truncates the message text to 320 characters" do
        expect(message.serialize[:message][:text]).to eq "Chase the pig around the house give attitude slap owner's face at 5am until human fills food dish scratch at the door then walk away or chase red laser dot cough furball but stick butt in face. Sleep on dog bed, force dog to sleep on floor cat snacks touch water with paw then recoil in horror throwup on your pillow use"
      end
    end
  end

end
