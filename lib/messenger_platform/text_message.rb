class MessengerPlatform::TextMessage < MessengerPlatform::MessageBase

  MAX_MESSAGE_LENGTH = 320

  attr_reader :message

  def initialize(recipient, message, notification_type = :regular)
    super(recipient, notification_type)
    @message = message.slice(0, MAX_MESSAGE_LENGTH)
  end

  def serialize
    super.merge({
      message: {
        text: message
      }
    })
  end

end
