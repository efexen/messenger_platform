require "rails_helper"

RSpec.describe MessengerPlatform::WebhookController, type: :controller do
  routes { MessengerPlatform::Engine.routes }

  describe ".subscribe" do

    context "no verify token" do
      it "responds with 400" do
        get :subscribe
        expect(response.status).to be 400
      end
    end

    context "invalid verify token" do
      it "responds with 400" do
        get :subscribe, "hub.verify_token" => "wrong"
        expect(response.status).to be 400
      end
    end

    context "valid verify token" do
      before { get :subscribe, "hub.verify_token" => "TEST_VERIFY_TOKEN", "hub.challenge" => "bunnies!" }

      it "responds with 200" do
        expect(response.status).to be 200
      end

      it "responds with the hub challenge" do
        expect(response.body).to eq "bunnies!"
      end
    end

  end

  describe ".message" do
    let(:test_data) do
      { entry: [{ messaging: [
        {
          "sender" => { "id" => "test_sender" },
          "recipient" => { "id" => "test_recipient" },
          "timestamp" => "123456",
          "message" => {
            "mid" => "mid.3834782374",
            "seq" => "1",
            "text" => "Bunnies!"
          }
        }
      ]}]}
    end

    it "responds with 200 OK" do
      post :message
      expect(response.status).to be 200
    end

    it "initializes a new inbound message with message data" do
      expect(MessengerPlatform::InboundMessage)
        .to(receive(:new).with(hash_including("sender", "recipient", "timestamp", "message")))

      post :message, test_data
    end

    it "initializes a new processor class" do
      expect(MessageProcessor).to receive(:new).and_call_original
      post :message, test_data
    end

    it "calls the process method of the processor class" do
      expect_any_instance_of(MessageProcessor).to receive(:process)
      post :message, test_data
    end

  end

end
