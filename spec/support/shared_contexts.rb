RSpec.shared_context 'user signed in' do
  let(:user) { create(:user) }

  before { sign_in user }
end

RSpec.shared_context 'mocked Saltedge' do
  before do
    allow(Saltedge).to receive(:request)
  end
end
