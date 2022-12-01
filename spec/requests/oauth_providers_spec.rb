require 'rails_helper'

RSpec.describe 'OauthProviders', type: :request do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }

  describe 'GET /authorize' do
    subject do
      get oauth_providers_authorize_url(access_token: 123, state: "connect_token_#{token}")
    end

    include_examples 'unauthorized request'

    let!(:connection) { create(:connection, customer: customer, data: data) }
    let(:data) do
      {
        token: token
      }
    end
    let(:token) { 'adfs1231432' }
    let(:oauth_providers) { double }
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

    context 'when user signed in' do
      include_context 'user signed in'

      it 'redirects to the connection' do
        subject
        expect(response).to redirect_to(connection_path(connection))
      end

      it 'calls saltedge api' do
        subject
        expect(oauth_providers).to have_received(:authorize)
      end

      context 'when connection belongs to another user' do
        let(:user2) { create(:user) }

        before { sign_in user2 }

        it 'redirects to connections' do
          subject
          expect(response).to redirect_to(connections_path)
        end
      end
    end
  end
end
