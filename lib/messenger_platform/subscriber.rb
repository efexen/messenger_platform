require 'httparty'

class MessengerPlatform::Subscriber

  def subscribe
    result = HTTParty.post(subscription_url, verify_peer: false)

    if result.code == 200
      puts "Subscribed successfully: #{ result.message }"
    else
      fail "Error Subscribing: #{ result.body }"
    end
  end

  private

  def subscription_url
    MessengerPlatform.facebook_api_base_url("subscribed_apps")
  end

end
