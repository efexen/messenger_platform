require 'faraday'

class MessengerPlatform::MessageSender

  def self.deliver(message)
    connection = Faraday.new(url: messages_url)

    connection.post do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Accept"] = "application/json"
      req.body = message.serialize.to_json
    end
  end

  private

  def self.messages_url
    MessengerPlatform.facebook_api_base_url("messages")
  end

end
