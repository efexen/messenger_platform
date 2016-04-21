class MessengerPlatform::MessageBase

  NOTIFICATION_TYPES = %i(regular silent_push no_push)

  attr_reader :recipient, :notification_type

  def initialize(recipient, notification_type = :regular)
    @recipient = recipient
    @notification_type = valid_notification_type(notification_type)
  end

  def serialize
    {
      recipient: serialize_recipient,
      notification_type: notification_type.to_s.upcase
    }
  end

  def deliver
    # TODO
  end

  private

  def serialize_recipient
    if recipient.respond_to?(:serialize)
      recipient.serialize
    else
      if recipient.starts_with?('+')
        { phone_number: recipient }
      else
        { id: recipient }
      end
    end
  end

  def valid_notification_type(notification_type)
    NOTIFICATION_TYPES.include?(notification_type) ? notification_type : :regular
  end

end
