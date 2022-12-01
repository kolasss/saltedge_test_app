require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  describe 'GET /show' do
    subject(:show) { get account_path(account) }

    let(:account) { create(:account) }

    include_examples 'unauthorized request'

    context 'when user is signed in' do
      include_examples 'authorized request'

      let(:user) { account.connection.customer.user }

      context 'when account belongs to another user' do
        include_examples 'request from unauthorized user'
      end
    end
  end
end
