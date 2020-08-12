# Dokku::Ruby

Small [Dokku](https://github.com/dokku/dokku) API for Ruby over SSH

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

Start a Dokku Session:
```
ssh = Dokku::SSH.new(
 host: 'http://example.com',
 user: 'deploy-user',
 key_file: '~/.ssh/id_dokku'
 )
```

Use that session to create apps on server:

```
ssh.start do |session|
	env = { env_var_one: '123', env_var_two: '456' }
	
	# Create a new Dokku application on the server
  session.create(app_name: 'my-dokku-app')

	# Set the environment config for that application
	session.set_env_vars(app_name: app_name, env_vars: env)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
