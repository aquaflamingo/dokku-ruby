# frozen_string_literal: true

RSpec.describe Dokku do
  describe '.start_session!' do
    context 'without user set' do
      it 'raises missing user error' do
        expect { Dokku.start_session! }.to raise_error(Dokku::MissingUserError)
      end
    end

    context 'without host set' do
      before do
        Dokku.config { |c| c.user = '123' }
      end

      it 'raises missing host error' do
        expect { Dokku.start_session! }.to raise_error(Dokku::MissingHostError)
      end
    end
  end
end
