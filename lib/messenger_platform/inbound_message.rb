class MessengerPlatform::InboundMessage

  attr_accessor :sender, :recipient, :timestamp, :message_id,
                :sequence, :text, :source_data, :attachments

  def initialize(hash)
    @source_data = hash
    @sender = MessengerPlatform::Contact.new(hash[:sender])
    @recipient = MessengerPlatform::Contact.new(hash[:recipient])
    @timestamp = hash[:timestamp]

    @message_id = message[:mid]
    @sequence = message[:seq]
    @text = message[:text]
    @attachments = parse_attachments
  end

  def attachments?
    attachments.any?
  end

  private

  def parse_attachments
    message.fetch(:attachments, []).map do |attachment|
      MessengerPlatform::Attachment.new(attachment)
    end
  end

  def message
    source_data.fetch(:message, {})
  end

end
