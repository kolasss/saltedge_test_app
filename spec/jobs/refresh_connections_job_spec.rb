require 'rails_helper'

RSpec.describe RefreshConnectionsJob, type: :job do
  before do
    create(:connection)
    create(:connection)

    allow(Connections::Refresh).to receive(:call)
  end

  it 'calls refresh for each connection' do
    described_class.perform_now
    expect(Connections::Refresh).to have_received(:call).twice
  end
end
