require 'spec_helper'

RSpec.describe MessengerPlatform::Attachment do

  describe 'type helper methods' do
    %w(image video audio).each do |context_type|
      context "#{context_type} attachment" do
        let(:attachment) { MessengerPlatform::Attachment.new({ type: context_type, url: 'test.png' }) }
        %w(image video audio).each do |test_type|
          describe ".#{test_type}?" do
            it "should return #{ context_type == test_type }" do
              expect(attachment.public_send("#{test_type}?")).to be context_type == test_type
            end
          end
        end
      end
    end
  end
end
