require 'rails_helper'

RSpec.describe Saltedge::Connections do
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
            fetch_scopes: %w[accounts transactions]
          },
          credentials: {
            login: 'username',
            password: 'secret'
          }
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :post,
        'connections',
        params
      )
    end
  end

  describe '.refresh' do
    subject { described_class.refresh(connection_id) }

    let(:connection_id) { '1234' }
    let(:params) do
      {
        data: {
          attempt: {
            fetch_scopes: %w[accounts transactions]
          }
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :put,
        "connections/#{connection_id}/refresh",
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
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            fetch_scopes: %w[accounts transactions]
          },
          credentials: {
            login: 'username',
            password: 'secret'
          }
        }
      }
    end

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :put,
        "connections/#{connection_id}/reconnect",
        params
      )
    end
  end

  describe '.destroy' do
    subject { described_class.destroy(connection_id) }

    let(:connection_id) { '1234' }

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :delete,
        "connections/#{connection_id}"
      )
    end
  end

  describe '.show' do
    subject { described_class.show(connection_id) }

    let(:connection_id) { '1234' }

    it 'calls api with right params' do
      subject
      expect(Saltedge).to have_received(:request).with(
        :get,
        "connections/#{connection_id}"
      )
    end
  end
end
