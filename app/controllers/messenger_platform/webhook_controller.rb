class MessengerPlatform::WebhookController < ActionController::Base

  def subscribe
    if params["hub.verify_token"] == MessengerPlatform.verify_token
      render plain: params["hub.challenge"], status: 200
    else
      head 400
    end
  end

  def message
    params.fetch(:entry, []).each do |entry|
      entry.fetch(:messaging, []).each do |message|
        process_message(message)
      end
    end

    head 200
  end

  private

  delegate :processor_class, :processor_method, to: :platform

  def process_message(message)
    inbound_message = MessengerPlatform::InboundMessage.new(message)
    processor_class.new(inbound_message).public_send(processor_method)
  end

  def platform
    MessengerPlatform
  end

end
