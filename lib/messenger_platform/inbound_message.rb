class MessengerPlatform::InboundMessage

  attr_accessor :sender, :recipient, :timestamp, :message_id,
                :sequence, :text, :source_data

  def initialize(hash)
    @source_data = hash
    @sender = MessengerPlatform::Contact.new(hash.fetch(:sender))
    @recipient = MessengerPlatform::Contact.new(hash.fetch(:recipient))
    @timestamp = hash.fetch(:timestamp)

    @message_id = message.fetch(:mid)
    @sequence = message.fetch(:seq)
    @text = message.fetch(:text)
  end

  private

  def message
    source_data[:message] || {}
  end

end
