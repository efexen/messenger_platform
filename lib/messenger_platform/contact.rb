class MessengerPlatform::Contact

  attr_reader :id

  def initialize(hash)
    @id = hash.fetch(:id)
  end

end
