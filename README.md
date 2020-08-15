# Dokku::Ruby

Small [Dokku](https://github.com/dokku/dokku) API for Ruby over SSHKit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dokku-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dokku-ruby

## Usage

Configure the Dokku client with desired set user, host and ssh options.

```
Dokku.config do |c|
  c.user = 'root'
  c.host = 'tradingbotplatformbook.com'
  c.ssh_options = { keys: '~/.ssh/id_trading_platform' }
end
```

Start a session, use the yielded block argument's DSL to create, delete and set environments for Dokku apps
```
Dokku.start_session! do |d|
  d.create!('app')
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
