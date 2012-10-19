# Smspilot

Ruby gem for smspilot.ru API

http://www.smspilot.ru/download/SMSPilotRu-HTTP-v2.1.2.rtf

## Installation

Add this line to your application's Gemfile:

    gem 'smspilot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smspilot

## Usage

create

```ruby
client = Smspilot.new api_key
#or
client = Smspilot.new (api_key: "yourkey", login: "yourlogin", password: "yourpass")
```

api methods

```ruby
result = client.send_sms(sms_id, sms_from, sms_to, message_text)

result = client.check_sms_status(sms_server_id)

result = client.check_balance
```

Use bang! methods if you want errors to be raised.
Otherwise access them through

```ruby
result.error
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


