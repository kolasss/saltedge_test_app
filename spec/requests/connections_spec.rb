require 'rails_helper'

RSpec.describe 'Connections', type: :request do
  let(:remote_api) { double }
  let(:process_result) do
    Dry::Monads::Success(
      {
        data: {
          id: '123123'
        }
      }
    )
  end
  let(:connection) { create(:connection) }

  before do
    allow(Saltedge).to receive(:connections).and_return(remote_api)
  end

  describe 'GET /index' do
    subject(:index) { get connections_path }

    include_examples 'unauthorized request'

    context 'when user is signed in' do
      include_examples 'authorized request'
    end
  end

  describe 'GET /show' do
    subject(:show) { get connection_path(connection) }

    include_examples 'unauthorized request'

    context 'when user is signed in' do
      include_examples 'authorized request'

      let(:user) { connection.customer.user }

      context 'when connection belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end

  describe 'GET /new' do
    subject { get new_connection_path }

    before do
      create(:provider)
    end

    include_examples 'unauthorized request'

    context 'when user is signed in' do
      include_examples 'authorized request'
    end
  end

  describe 'POST /create' do
    subject { post connections_path(provider_code: provider_code) }

    include_examples 'unauthorized request'

    let!(:provider) { create(:provider) }
    let(:provider_code) { provider.code }
    let(:process_result) do
      Dry::Monads::Success(
        {
          data: {
            connection_id: '123123',
            redirect_url: redirect_url
          }
        }
      )
    end
    let(:redirect_url) { 'www.saltedge.com/asdf' }

    before do
      allow(Saltedge).to receive(:oauth_providers).and_return(remote_api)
      allow(remote_api).to receive(:create).and_return(process_result)
    end

    context 'with valid parameters' do
      include_context 'user signed in'

      before { create(:customer, user: user) }

      it 'creates a new connection' do
        expect { subject }.to change(Connection, :count).by(1)
      end

      it 'redirects to the remote service' do
        subject
        expect(response).to redirect_to(redirect_url)
      end

      it 'calls remote api' do
        subject
        expect(remote_api).to have_received(:create)
      end
    end

    context 'with invalid parameters' do
      include_context 'user signed in'

      let(:provider_code) { 'invlid' }

      it 'does not create a new connection' do
        expect { subject }.to change(Connection, :count).by(0)
      end

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connections_path)
      end

      it 'does not call remote api' do
        subject
        expect(remote_api).not_to have_received(:create)
      end
    end
  end

  describe 'PUT /refresh' do
    subject { put refresh_connection_path(connection) }

    include_examples 'unauthorized request'

    before do
      allow(remote_api).to receive(:refresh).and_return(process_result)
    end

    context 'when user signed in' do
      include_context 'user signed in'

      let(:user) { connection.customer.user }

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connection_path(connection))
      end

      it 'calls remote api' do
        subject
        expect(remote_api).to have_received(:refresh)
      end

      context 'when connection belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end

  describe 'PUT /reconnect' do
    subject { put reconnect_connection_path(connection) }

    include_examples 'unauthorized request'

    before do
      allow(remote_api).to receive(:reconnect).and_return(process_result)
    end

    context 'when user signed in' do
      include_context 'user signed in'

      let(:user) { connection.customer.user }

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connection_path(connection))
      end

      it 'calls remote api' do
        subject
        expect(remote_api).to have_received(:reconnect)
      end

      context 'when connection belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end

  describe 'PUT /fetch' do
    subject { put fetch_connection_path(connection) }

    include_examples 'unauthorized request'

    let(:list_result) do
      Dry::Monads::Success(
        {
          data: [{
            id: '123123'
          }]
        }
      )
    end
    let(:account) { create(:account, connection: connection) }

    before do
      allow(Saltedge).to receive(:transactions).and_return(remote_api)
      allow(Saltedge).to receive(:accounts).and_return(remote_api)
      allow(remote_api).to receive(:show).and_return(process_result)
      allow(remote_api).to receive(:list).and_return(list_result)

      create(:transaction, account: account)
    end

    context 'when user signed in' do
      include_context 'user signed in'

      let(:user) { connection.customer.user }

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connection_path(connection))
      end

      it 'calls remote api' do
        subject
        expect(remote_api).to have_received(:show).once
        expect(remote_api).to have_received(:list).twice
      end

      context 'when connection belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end

  describe 'DELETE /destroy' do
    subject { delete connection_path(connection) }

    include_examples 'unauthorized request'

    before do
      allow(remote_api).to receive(:destroy).and_return(process_result)
    end

    context 'when user signed in' do
      include_context 'user signed in'

      let(:user) { connection.customer.user }

      it 'destroys connection' do
        expect { subject }.to change(Connection, :count).by(-1)
      end

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connections_path)
      end

      it 'calls remote api' do
        subject
        expect(remote_api).to have_received(:destroy)
      end

      context 'when connection belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end

  describe 'PUT /refresh_all' do
    subject { put refresh_all_connections_path }

    include_examples 'unauthorized request'

    before do
      allow(remote_api).to receive(:refresh).and_return(process_result)
    end

    context 'when user signed in' do
      include_context 'user signed in'

      it 'enqueues job' do
        assert_enqueued_with(job: RefreshConnectionsJob) do
          subject
        end
      end

      it 'redirects to connections' do
        subject
        expect(response).to redirect_to(connections_path)
      end
    end
  end
end
