module MessengerPlatform
  class Engine < ::Rails::Engine
    isolate_namespace MessengerPlatform
  end

  class << self
    mattr_accessor :verify_token
    mattr_accessor :access_token
  end

  def self.setup
    yield self
  end

end
