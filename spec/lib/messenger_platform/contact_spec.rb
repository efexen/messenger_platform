require "spec_helper"

RSpec.describe MessengerPlatform::Contact do

  describe ".serialize" do
    let(:contact) { MessengerPlatform::Contact.new(contact_params) }

    context "only id" do
      let(:contact_params) { { id: "123" } }

      it "returns hash containing id" do
        expect(contact.serialize).to eq({ id: "123" })
      end
    end

    context "only phone number" do
      let(:contact_params) { { phone_number: "+1(233)42341" } }

      it "returns hash containing phone_number" do
        expect(contact.serialize).to eq({ phone_number: "+1(233)42341" })
      end
    end

    context "both id and phone number" do
      let(:contact_params) { { id: "123", phone_number: "+1(233)42341" } }

      it "returns hash containing id" do
        expect(contact.serialize).to eq({ id: "123" })
      end
    end

  end

end
