class MessengerPlatform::MessageBase

  attr_reader :recipient, :notification_type

  def initialize(recipient, notification_type = :regular)
    @recipient = recipient
    @notification_type = notification_type
  end

  def serialize
    {
      recipient: recipient.serialize,
      notification_type: notification_type.to_s.upcase
    }
  end

  def deliver
    MessengerPlatform::MessageSender.deliver(self)
  end

end
