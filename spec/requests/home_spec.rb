require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /index' do
    subject(:index) { get '/home/index' }

    context 'when user is not signed in' do
      it 'returns http success' do
        index
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'returns http success' do
        index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
