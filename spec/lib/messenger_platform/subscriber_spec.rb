RSpec.describe MessengerPlatform::Subscriber do

  describe '.subscribe' do

    context 'unsuccessful subscribe' do

      before do
        stub_request(:any, /.*facebook\.com.*/)
          .to_return(body: 'bad stuff', status: 400)
      end

      it 'logs error' do
        expect(Rails.logger).to receive(:fatal).with(/Error.*bad stuff.*/)
        MessengerPlatform::Subscriber.new.subscribe
      end

    end

    context 'successful subscribe' do
      before do
        stub_request(:any, /.*facebook\.com.*/)
          .to_return(status: 200)
      end

      it 'logs success message' do
        expect(Rails.logger).to receive(:info).with(/success/)
        MessengerPlatform::Subscriber.new.subscribe
      end

    end

  end

end
