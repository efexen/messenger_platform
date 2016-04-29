require "messenger_platform/engine"
require "messenger_platform/subscriber"
require "messenger_platform/inbound_message"
require "messenger_platform/contact"
require "messenger_platform/message_base"
require "messenger_platform/text_message"
require "messenger_platform/message_sender"
require "messenger_platform/attachment"

module MessengerPlatform

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
