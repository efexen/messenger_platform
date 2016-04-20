module MessengerPlatform
  class Engine < ::Rails::Engine
    isolate_namespace MessengerPlatform
  end

  class << self
    mattr_accessor :verify_token, :access_token, :processor_class, :processor_method

    self.processor_method = :process
  end

  def self.setup
    yield self
  end

end
