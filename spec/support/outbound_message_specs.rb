shared_examples "an outbound message" do

  let(:message) { described_class.new(recipient, "") }

  describe ".serialize" do
    describe 'returned hash' do

      it "contains regular notification" do
        expect(message.serialize[:notification_type]).to eq "REGULAR"
      end

      it "contains serialized recipient" do
        serialized_recipient = double
        allow(recipient).to receive(:serialize) { serialized_recipient }

        expect(message.serialize[:recipient]).to eq serialized_recipient
      end

      context "for a silent notification" do
        let(:message) { described_class.new(recipient, "", :silent_push) }

        it "contains silent notification" do
          expect(message.serialize[:notification_type]).to eq "SILENT_PUSH"
        end
      end
    end
  end

  describe ".deliver" do

    it "leverages the message sender" do
      expect(MessengerPlatform::MessageSender).to receive(:deliver).with(message)
      message.deliver
    end
  end

end
