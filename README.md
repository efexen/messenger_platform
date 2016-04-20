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

### InboundMessage class

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

### Contact class

Contact class contains the id of the sender or the recipient

|Attribute  |Example    |Explanation
|----       |-----      |-----
|id         | 123       | User ID

## TODO 

Off the top of my head in no particular order

- Tests
- Better documentation
- Missing README sections: Contributing, Licence etc
- CodeClimate, TravisCI etc
- Ability to send basic text messages to a user
- Support for complex messages with attachments 
- Support for sending different types of messages to user
    - Structured Messages
- Support for structured message postbacks
- Additional Facebook APIs that support the usage such as Profile API
- "Send to Messenger" button helpers
- "Message Us" button helpers
- Messenger Code?
