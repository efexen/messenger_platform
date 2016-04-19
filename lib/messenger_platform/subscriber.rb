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
    "https://graph.facebook.com/v2.6/me/subscribed_apps?access_token=#{ MessengerPlatform.access_token }"
  end

end
