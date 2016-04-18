module MessengerPlatform
  class WebhookController < ActionController::Base

    def subscribe
      if params["hub.verify_token"] == MessengerPlatform.verify_token
        render plain: params["hub.challenge"], status: 200
      else
        head 400
      end
    end

    def message
      head 202
    end

  end
end
