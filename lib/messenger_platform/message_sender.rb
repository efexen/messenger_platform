require 'httparty'

class MessengerPlatform::MessageSender

  def self.deliver(message)
    HTTParty.post(messages_url, {
      body: message.serialize.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    })
  end

  private

  def self.messages_url
    MessengerPlatform.facebook_api_base_url("messages")
  end

end
