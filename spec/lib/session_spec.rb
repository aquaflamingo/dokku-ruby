# frozen_string_literal: true

require 'dokku/session'

RSpec.describe Dokku::Session do
  let(:ssh_session) { spy('session') }

  subject(:dokku) do
    Dokku::Session.new(ssh_session)
  end

  describe '#create' do
    it 'executes the command' do
      expect_any_instance_of(Logger).to receive(:info).twice.and_call_original

      dokku.create(app_name: 'app_name')

      expect(ssh_session).to have_received(:exec!).with('dokku apps:create app_name')
    end
  end

  describe '#destroy' do
    it 'executes the command' do
      expect_any_instance_of(Logger).to receive(:info).twice.and_call_original
      dokku.destroy(app_name: 'app_name')

      expect(ssh_session).to have_received(:exec!).with('dokku --force apps:destroy app_name')
    end
  end

  describe '#set_env_vars' do
    it 'executes the command' do
      expect_any_instance_of(Logger).to receive(:info).twice.and_call_original

      dokku.set_env_vars(app_name: 'app_name', env_vars: { env_one: '123' })

      expect(ssh_session).to have_received(:exec!).with('dokku config:set app_name ENV_ONE=123')
    end
  end
end
