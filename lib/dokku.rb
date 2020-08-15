# frozen_string_literal: true

require 'sshkit'
require 'sshkit/dsl'
require 'dokku/version'
require 'dokku/configuration'
require 'dokku/dsl'

module Dokku
  extend SSHKit::DSL

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    yield(configuration)

    SSHKit::Backend::Netssh.configure do |ssh|
      unless configuration.ssh_options.nil?
        ssh.ssh_options = configuration.ssh_options
      end
    end
  end

  class DokkuError < StandardError; end
  class MissingUserError < DokkuError; end
  class MissingHostError < DokkuError; end

  def self.start_session!
    on ssh_target do
      # self is an SSH context
      yield Dokku::DSL.new(self)
    end
  end

  def self.ssh_target
    user = configuration.user
    host = configuration.host

    if user.nil? || user == ''
      raise MissingUserError, 'User not set. Did you add it to the configuration?'
    end

    if host.nil? || host == ''
      raise MissingHostError, 'Host is not set. Did you add it to the configuration?'
    end

    "#{user}@#{host}"
   end
end
