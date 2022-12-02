require 'rails_helper'

RSpec.describe Saltedge::Transactions do
  include_context 'mocked Saltedge'

  describe '.list' do
    subject { described_class.list(connection_id, account_id) }

    let(:connection_id) { '1234' }
    let(:account_id) { '1234123' }

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :get,
        "transactions?connection_id=#{connection_id}&account_id=#{account_id}"
      )
    end
  end
end
