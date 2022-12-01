RSpec.shared_context 'user signed in' do
  let(:user) { create(:user) }

  before { sign_in user }
end
