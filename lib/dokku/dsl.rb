# frozen_string_literal: true

require 'sshkit/dsl'

module Dokku
  class DSL
    include SSHKit::DSL

    CREATE_APP_CMD = 'apps:create'
    CONFIG_SET_CMD = 'config:set'
    FORCE_DELETE_APP_CMD = '--force apps:destroy'

    def create!(app_name)
      binding.pry
      execute :dokku, CREATE_APP_CMD, app_name
    end

    def destroy!(app_name)
      execute :dokku, FORCE_DELETE_APP_CMD, app_name
    end

    def set_config(app_name:, **config)
      execute :dokku, CONFIG_SET_CMD, app_name, redact(hash_to_env_vars(config))
    end

    private

    def hash_to_env_vars(hash)
      hash.map do |k, v|
        "#{k.upcase}=#{v}"
      end.join(' ')
    end
  end
end
