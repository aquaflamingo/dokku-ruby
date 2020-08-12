# frozen_string_literal: true

require 'logger'

module Dokku
  class Session
    def initialize(session, logger = Logger.new(STDOUT))
      @session = session
      @logger = logger
    end

    def create(app_name:)
      command = "dokku apps:create #{app_name}"
      @logger.info command
      @logger.info @session.exec!(command)
    end

    def set_env_vars(app_name:, env_vars:)
      env = hash_to_env_vars(env_vars)

      command = "dokku config:set #{app_name} #{env}"

      stdout = ''
      @logger.info "dokku config:set #{app_name}"
      @session.exec!(command) do |_channel, stream, data|
        stdout << redact_sensitive(data) if stream == :stdout
      end

      @logger.info stdout
    end

    def destroy(app_name:)
      command = "dokku --force apps:destroy #{app_name}"
      @logger.info command
      @logger.info @session.exec!(command)
    end

    private

    def hash_to_env_vars(hash)
      hash.map do |k, v|
        "#{k.upcase}=#{v}"
      end.join(' ')
    end

    def redact_sensitive(s)
      redactable = s.scan(/KEY|SECRET|TOKEN|PASSPHRASE/)

      if redactable&.empty?
        s
      else
        delimiter = '=' * 25
        "\n#{delimiter}\n\nOUTPUT REDACTED\n\n#{delimiter}\n"
      end
    end
  end
end
