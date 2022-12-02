require 'rails_helper'

RSpec.describe Saltedge::Accounts do
  include_context 'mocked Saltedge'

  describe '.list' do
    subject { described_class.list(connection_id) }

    let(:connection_id) { '1234' }

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :get,
        "accounts?connection_id=#{connection_id}"
      )
    end
  end
end
