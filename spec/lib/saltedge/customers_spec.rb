require 'rails_helper'

RSpec.describe Saltedge::Customers do
  include_context 'mocked Saltedge'

  describe '.create' do
    subject { described_class.create(identifier) }

    let(:identifier) { '1234' }

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :post,
        'customers',
        {
          data: {
            identifier: identifier
          }
        }
      )
    end
  end
end
