class MessengerPlatform::Contact

  attr_reader :id, :phone_number

  def initialize(hash)
    @id = hash.fetch(:id)
    @phone_number = hash.fetch(:phone_number)
  end

  def serialize
    id.present? ? { id: id } : { phone_number: phone_number }
  end

end
