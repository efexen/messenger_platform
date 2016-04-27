class MessageProcessor

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def process
    if message.text
      reply = MessengerPlatform::TextMessage.new(message.sender, message.text)
      reply.deliver
    end
  end

end
