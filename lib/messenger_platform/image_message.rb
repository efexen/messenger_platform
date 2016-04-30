class MessengerPlatform::ImageMessage < MessengerPlatform::MessageBase

  def initialize(recipient, image_url, notification_type = :regular)
    super(recipient, notification_type)
    @image_url = image_url
  end

  def serialize
    super.merge({
      message: {
        attachment: {
          type: "image",
          payload: { url: @image_url }
        }
      }
    })
  end

end
