require 'faraday'

class MessengerPlatform::Subscriber

  def subscribe
    result = Faraday.post(subscription_url)

    if result.success?
      puts "Subscribed successfully"
    else
      fail "Error Subscribing: #{ result.body }"
    end
  end

  private

  def subscription_url
    MessengerPlatform.facebook_api_base_url("subscribed_apps")
  end

end
