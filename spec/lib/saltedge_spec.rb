require 'rails_helper'

RSpec.describe Saltedge do
  describe '.request' do
    subject { described_class.request(method, path, params) }

    let(:method) { :get }
    let(:params) { {} }

    context 'with successfull response' do
      let(:path) { 'connections/892183610050747031' }

      it 'returns success' do
        VCR.use_cassette 'connections' do
          expect(subject).to be_success
        end
      end

      it 'parses json' do
        VCR.use_cassette 'connections' do
          expect(subject.value!.dig(:data, :id)).to eq('892183610050747031')
        end
      end
    end

    context 'with unsuccessfull response' do
      let(:path) { 'connections/1234556' }

      it 'returns failure' do
        VCR.use_cassette 'connections' do
          expect(subject).not_to be_success
        end
      end

      it 'parses json' do
        VCR.use_cassette 'connections' do
          expect(subject.failure[:error]).to be_present
        end
      end
    end
  end

  describe '.customers' do
    it 'returns Saltedge::Customers' do
      expect(described_class.customers).to eq(Saltedge::Customers)
    end
  end

  describe '.connections' do
    it 'returns Saltedge::Connections' do
      expect(described_class.connections).to eq(Saltedge::Connections)
    end
  end

  describe '.accounts' do
    it 'returns Saltedge::Accounts' do
      expect(described_class.accounts).to eq(Saltedge::Accounts)
    end
  end

  describe '.transactions' do
    it 'returns Saltedge::Transactions' do
      expect(described_class.transactions).to eq(Saltedge::Transactions)
    end
  end

  describe '.oauth_providers' do
    it 'returns Saltedge::OauthProviders' do
      expect(described_class.oauth_providers).to eq(Saltedge::OauthProviders)
    end
  end
end
