RSpec.shared_examples 'unauthorized request' do
  context 'when user is not signed in' do
    it 'redirects to sign in' do
      subject
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

RSpec.shared_examples 'authorized request' do
  include_context 'user signed in'

  it 'returns http success' do
    subject
    expect(response).to have_http_status(:success)
  end
end

RSpec.shared_examples 'request from unauthorized user' do
  let(:user) { create(:user) }

  it 'raises error' do
    expect { subject }.to raise_error ActiveRecord::RecordNotFound
  end
end
