# frozen_string_literal: true

require 'net/ssh'

module Dokku
  class SSH
    def initialize(**params)
      @host = params[:host]
      @user = params[:user]
      @key_file = params[:key_file]
      @keys_only = params[:keys_only] ||= true
      @key_type = params[:key_type] ||= 'ssh-rsa'
    end

    def start
      Net::SSH.start(
        @host,
        @user,
        host_key: @key_type,
        keys_only: @keys_only,
        keys: @key_file,
        verbose: :error
      ) do |s|
        yield Dokku::Session.new(s)
      end
    end
    end
end
