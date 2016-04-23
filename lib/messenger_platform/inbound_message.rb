class MessengerPlatform::InboundMessage

  attr_accessor :sender, :recipient, :timestamp, :message_id,
                :sequence, :text, :source_data

  def initialize(hash)
    @source_data = hash
    @sender = MessengerPlatform::Contact.new(hash[:sender])
    @recipient = MessengerPlatform::Contact.new(hash[:recipient])
    @timestamp = hash[:timestamp]

    @message_id = message[:mid]
    @sequence = message[:seq]
    @text = message[:text]
  end

  private

  def message
    source_data.fetch(:message, {})
  end

end
