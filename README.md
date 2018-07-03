# evok-to-mqtt

A bridge between Unipi's EVOK and MQTT message bus. It uses websockets to connect to Evok and mqtt library to connecto to MQTT broker (e.g. Mosquitto).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'evok-to-mqtt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install evok-to-mqtt

## Usage

```bash
$ evok-to-mqtt <evok_hostname> <mqtt_host>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/evok-to-mqtt.

## License

The gem is available as open source under the terms of the [Apache](https://opensource.org/licenses/apache).
