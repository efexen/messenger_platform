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

  def self.facebook_api_base_url(api_method)
    uri = URI("https://graph.facebook.com/v2.6/me/#{ api_method }")
    uri.query = URI.encode_www_form({ access_token: MessengerPlatform.access_token })
    uri.to_s
  end

end
