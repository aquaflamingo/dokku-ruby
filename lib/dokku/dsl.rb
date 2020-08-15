# frozen_string_literal: true

require 'sshkit/dsl'

module Dokku
  class DSL
    include SSHKit::DSL

    CREATE_APP_CMD = 'apps:create'
    CONFIG_SET_CMD = 'config:set'
    FORCE_DELETE_APP_CMD = '--force apps:destroy'

    def initialize(runner, logger = Logger.new(STDOUT))
      @runner = runner
      @logger = logger
    end

    def create!(app_name)
      @logger.info("dokku #{CREATE_APP_CMD} #{app_name}")
      @runner.execute :dokku, CREATE_APP_CMD, app_name
    end

    def destroy!(app_name)
      @logger.info("dokku #{FORCE_DELETE_APP_CMD} #{app_name}")
      @runner.execute :dokku, FORCE_DELETE_APP_CMD, app_name
    end

    def set_config(app_name:, **config)
      @logger.info("dokku #{CONFIG_SET_CMD} #{app_name} REDACTED")
      @runner.execute :dokku, CONFIG_SET_CMD, app_name, redact(hash_to_env_vars(config))
    end

    private

    def hash_to_env_vars(hash)
      hash.map do |k, v|
        "#{k.upcase}=#{v}"
      end.join(' ')
    end
  end
end
