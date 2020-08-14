# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dokku::DSL do
  subject(:dokku) do
    Dokku::DSL.new
  end

  describe '#create' do
    it 'executes the command' do
      dokku.create!('app_name')

      expect(SSHKit::DSL).to have_received(:execute).with('dokku apps:create app_name')
    end
  end

  describe '#destroy' do
    it 'executes the command' do
      dokku.destroy!('app_name')

      expect(SSHKit::DSL).to have_received(:execute).with('--force dokku apps:create app_name')
    end
  end

  describe '#set_env_vars' do
    it 'executes the command' do
      dokku.set_env_vars(app_name: 'app_name', env_one: '123')

      expect(SSHKit::DSL).to have_received(:execute).with('dokku config:set app_name ENV_ONE=123')
    end
  end
end
