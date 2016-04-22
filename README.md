# Messenger Platform Rails

This project aims to be a complete solution for integrating the Facebook Messenger Platform to your Rails application.

**Do note this project is very much Work in Progress**

## Installation

**Install the Gem**

Add to your `Gemfile`

```
gem "messenger_platform_rails"
```

**Mount the engine**

Mount in your `config/routes.rb`

```
mount MessengerPlatform::Engine, at: "/hookie_hook"
```

This will mount the following routes in your application:

|Path           |Verb       |Usage
|-----          |----       |----
|/hookie_hook   |GET        | Used for initial verification when setting up the webhook urls|
|/hookie_hook   |POST       | Used for receiving incoming messages

**Configure**

Configure using an initializer such as `config/initializers/messenger_platform.rb`

```
MessengerPlatform.setup do |config|
    config.verify_token = '<YOUR VERIFICATION TOKEN>`
    config.access_token = '<YOUR ACCESS TOKEN>'
    
    config.processor_class = MessageProcessor
    config.processor_method = :do_thing
end
```

|Option             |Usage
|-----              |-----
|verify_token       | Used for initial verification during webhook setup
|access_token       | Page Access Token used for subscription rake task and for sending messages
|processor_class    | Class to be initialized with an instance of MessengerPlatform::InboundMessage
|processor_method   | Method to call on the processor_class instance to process the message, default is :process

## Usage

#### Verify Webhook
The gem provides an endpoint that will respond correctly to the verification challenge set by the Facebook Webhook configuration dialog using the values set in your configuration

#### Subscribing the App to the Page
The gem includes a convenience rake task to create the appropriate subscription using the Page Access token from your configuration.

```sh
rake messenger_platform:subscribe
```

#### Example Processor Class
You can now create your own processor class as per your configuration

```ruby
class MessageProcessor
    
    def initialize(message)
        @message = message
    end
    
    def do_thing
        # This gets invoked whenever a message is received
    end
    
end
```

The message argument received is of type `MessengerPlatform::InboundMessage`

#### InboundMessage class

InboundMessage class contains parsed and raw data of the message received. It contains the following attributes

|Attribute      |Example      |Explanation
|----           |-----        |----
|sender         |MessengerPlatform::Contact | Sender of message
|recipient      |MessengerPlatform::Contact | Recipient of message
|timestamp      |1458696618911 | Timestamp of message
|message_id     |mid.1457764197618:41d102a3e1ae206a38 | Message Id
|sequence       |73 | Message Sequence Number
|text           |"Helloo"   | Text of the message

These more of less map directly to the attributes in the official Messenger Platform documentation
<https://developers.facebook.com/docs/messenger-platform/webhook-reference#received_message>

**Do note only basic text messages are currently implemented**

#### Contact class

Contact class contains the id and/or phone number of the sender or the recipient.

|Attribute    |Example          |Explanation
|----         |-----            |-----
|id           | 123             | User ID
|phone_number | +1(212)555-2368 | Users Phone Number

Valid Examples

```ruby
MessengerPlatform::Contact.new({ id: 12312312 })
MessengerPlatform::Contact.new({ phone_number: '+1(212)555-1233' })
MessengerPlatform::Contact.new({ id: 123123, phone_number: '+1(212)555-1233' })
```

If the contact class contains both id and phone number when serialized for sending messages; the id is preferred over the phone number when present.

#### TextMessage class

TextMessage class describes a basic message containing plain text to be sent to the user.

|Attribute          |Example        |Explanation
|------             |-----          |-----
|recipient          |               | Instance of Contact class
|message            |"Hello"        | Text to send in UTF8, max 320 characters
|notification_type  |:silent_push   | Notification type, default :regular

Valid notification types are `regular`, `silent_push`, `no_push` these map directly to the notification types in the official documentation <https://developers.facebook.com/docs/messenger-platform/send-api-reference#request>

To send the message, call the `.deliver` instance method, this will create the appropriate POST request to Facebook API.

Valid examples

```ruby
contact = MessengerPlatform::Contact.new({ id: 12312312 })

MessengerPlatform::TextMessage.new(contact, "Hello") # => default notification type
MessengerPlatform::TextMessage.new(contact, "Hi", :silent_push)
MessengerPlatform::TextMessage.new(contact, "Yo", :no_push)

```

## Examples

### Sending a text message example

```ruby
contact = MessengerPlatform::Contact.new({ id: 13123123 })
message = MessengerPlatform::TextMessage(contact, "Hello there")

message.deliver
```

### Echo service

```ruby
class MessageService

    def initialize(message)
        @message = message
    end

    def echo
      reply = MessengerPlatform::TextMessage.new(@message.sender, @message.text)
      reply.deliver
    end

end

```

## TODO

Off the top of my head in no particular order

- Tests
- Better documentation
- Missing README sections: Contributing, Licence etc
- CodeClimate, TravisCI etc
- Support for complex messages with attachments 
- Support for sending different types of messages to user
    - Structured Messages
- Support for structured message postbacks
- Additional Facebook APIs that support the usage such as Profile API
- "Send to Messenger" button helpers
- "Message Us" button helpers
- Messenger Code?
