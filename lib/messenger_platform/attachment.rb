class MessengerPlatform::Attachment

  VALID_TYPES = %w(image video audio)

  attr_reader :url, :type

  def initialize(hash)
    @url = hash[:url]
    @type = hash[:type]
  end

  VALID_TYPES.each do |valid_type|
    define_method "#{valid_type}?" do
      type == valid_type
    end
  end

end
