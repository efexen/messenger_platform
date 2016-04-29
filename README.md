# Messenger Platform Rails
[![Gem Version](https://badge.fury.io/rb/messenger_platform_rails.svg)](https://badge.fury.io/rb/messenger_platform_rails)
[![Code Climate](https://codeclimate.com/github/efexen/messenger_platform/badges/gpa.svg)](https://codeclimate.com/github/efexen/messenger_platform)
[![Build Status](https://travis-ci.org/efexen/messenger_platform.svg?branch=master)](https://travis-ci.org/efexen/messenger_platform)

## Description

Messenger Platform Rails aims to be a complete solution for integrating the Facebook Messenger Platform to your Rails application.

Currently it provides following capabilities:

- Respond to Facebook Webhook verification challenge
- Subscribe App to a Page
- Receive text messages
- Receive messages with attachments
- Send text messages to users

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
|attachments    |[ ]         | Array of MessengerPlatform::Attachment instances

These more or less map directly to the attributes in the official Messenger Platform documentation
<https://developers.facebook.com/docs/messenger-platform/webhook-reference#received_message>

The message may contain several attachments, convenience method `.attachments?` can be used to check for presence of attachments.

Messages with no attachments will respond to `.attachments` with an empty array.

#### Contact class

Contact class contains the id and/or phone number of the sender or the recipient.

|Attribute    |Example          |Explanation
|----         |-----            |-----
|id           | 123             | User ID
|phone_number | +1(212)555-2368 | Users Phone Number

If the contact class contains both id and phone number when serialized for sending messages; the id is preferred over the phone number when present.

Valid Examples

```ruby
MessengerPlatform::Contact.new({ id: 12312312 })
MessengerPlatform::Contact.new({ phone_number: '+1(212)555-1233' })
MessengerPlatform::Contact.new({ id: 123123, phone_number: '+1(212)555-1233' })
```

#### Attachment class

Attachment class contains the type and url of the message attachment as well as several convenience methods for type.

|Attribute    |Example                  |Explanation
|-----        |------                   |------
|type         |"image"                  | Type of attachment, see below for valid types
|url          |"http://...bunnies.png"  | URL that can be used to retrieve the attachment

Valid types are `image`, `video` and `audio`, convenience methods `image?`, `video?` and `audio?` can be used to check for the type.

Valid Examples

```ruby
attachment = MessengerPlatform::Attachment.new({ type: "image", url: "bunnies.png" })

attachment.image? #=> true
attachment.video? #=> false
attachment.url #=> "bunnies.png"
```

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
      if @message.text # Some messages are delivery notices without text
        reply = MessengerPlatform::TextMessage.new(@message.sender, @message.text)
        reply.deliver
      end
    end

end

```

## Versioning

Semantic versioning (http://semver.org/spec/v2.0.0.html) is used. 

For a version number MAJOR.MINOR.PATCH, unless MAJOR is 0:

1. MAJOR version is incremented when incompatible API changes are made,
2. MINOR version is incremented when functionality is added in a backwards-compatible manner, 
3. PATCH version is incremented when backwards-compatible bug fixes are made.

Major version "zero" (0.y.z) is for initial development. Anything may change at any time. 
The public API should not be considered stable. 
Furthermore, version "double-zero" (0.0.x) is not intended for public use, 
as even minimal functionality is not guaranteed to be implemented yet.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
