# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Dokku::Configuration do
  subject(:c) { Dokku::Configuration.new }

  it 'sets ssh_options' do
    c.ssh_options = { keys: '123' }

    expect(c.ssh_options).to eq({ keys: '123' })
  end

  it 'sets host' do
    c.host = 'bitcoin.com'
    expect(c.host).to match('bitcoin.com')
  end

  it 'sets user' do
    c.user = 'satoshi_nakamoto'

    expect(c.user).to match(/satoshi_nakamoto/)
  end
end
