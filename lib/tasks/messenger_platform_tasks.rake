namespace :messenger_platform do

  desc "Subscribe the App to the Page using Page Access Token"
  task subscribe: :environment do

    if MessengerPlatform.access_token.present?
      MessengerPlatform::Subscriber.new.subscribe
    else
      fail "Missing Access Token"
    end
  end

end
