require 'rails_helper'

RSpec.describe Saltedge::OauthProviders do
  include_context 'mocked Saltedge'

  describe '.create' do
    subject { described_class.create(customer_id: customer_id, provider_code: provider_code) }

    let(:customer_id) { '1234' }
    let(:provider_code) { 'qweqwe' }
    let(:params) do
      {
        data: {
          customer_id: customer_id,
          country_code: 'XF',
          provider_code: provider_code,
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            fetch_scopes: %w[accounts transactions],
            return_to: 'http://localhost:3000/oauth_providers/authorize'
          },
          return_connection_id: true
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :post,
        'oauth_providers/create',
        params
      )
    end
  end

  describe '.authorize' do
    subject { described_class.authorize(connection_id, query_string) }

    let(:connection_id) { '1234' }
    let(:query_string) { 'state=asdasd&code=234234' }
    let(:params) do
      {
        data: {
          connection_id: connection_id,
          query_string: query_string
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :put,
        'oauth_providers/authorize',
        params
      )
    end
  end

  describe '.reconnect' do
    subject { described_class.reconnect(connection_id) }

    let(:connection_id) { '1234' }
    let(:params) do
      {
        data: {
          connection_id: connection_id,
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            fetch_scopes: %w[accounts transactions],
            return_to: 'http://localhost:3000/oauth_providers/authorize'
          },
          return_connection_id: true
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :post,
        'oauth_providers/reconnect',
        params
      )
    end
  end
end
