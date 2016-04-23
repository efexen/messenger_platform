MessengerPlatform.setup do |config|
  config.verify_token = 'TEST_VERIFY_TOKEN'
  config.access_token = 'TEST_ACCESS_TOKEN'

  config.processor_class = MessageProcessor
end
