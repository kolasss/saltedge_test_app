require 'rails_helper'

RSpec.describe 'OauthProviders', type: :request do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }

  describe 'GET /authorize' do
    let!(:connection) { create(:connection, customer: customer, data: data) }
    let(:data) do
      {
        token: token
      }
    end
    let(:token) { 'adfs1231432' }
    let(:oauth_providers) { double }
    let(:saltedge) { double(customers: oauth_providers) }
    let(:process_result) do
      Dry::Monads::Success(
        {
          data: {
            id: connection.saltedge_id
          }
        }
      )
    end

    before do
      allow(Saltedge).to receive(:oauth_providers).and_return(oauth_providers)
      allow(oauth_providers).to receive(:authorize).and_return(process_result)
    end

    before { sign_in user }

    it 'redirects to the connection' do
      get oauth_providers_authorize_url(
        access_token: 123,
        state: "connect_token_#{token}"
      )
      expect(response).to redirect_to(connection_path(connection))
    end

    it 'calls saltedge api' do
      get oauth_providers_authorize_url(
        access_token: 123,
        state: "connect_token_#{token}"
      )
      expect(oauth_providers).to have_received(:authorize)
    end
  end
end
