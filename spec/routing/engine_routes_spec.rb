require 'rails_helper'

RSpec.describe MessengerPlatform::WebhookController, type: :routing do
  routes { MessengerPlatform::Engine.routes }

  it 'routes GET root to webhook#subscribe' do
    expect(get: '/').to route_to(controller: 'messenger_platform/webhook', action: 'subscribe')
  end

  it 'routes POST root to webhook#message' do
    expect(post: '/').to route_to(controller: 'messenger_platform/webhook', action: 'message')
  end

end
