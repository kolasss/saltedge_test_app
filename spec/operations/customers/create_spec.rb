require 'rails_helper'

RSpec.describe Customers::Create do
  subject(:result) do
    described_class.call(user)
  end

  let(:user) do
    create(:user)
  end
  let(:remote_api) { double }
  let(:process_result) do
    Dry::Monads::Success(
      {
        data: {
          id: customer_id,
          identifier: 'user@example.com',
          created_at: '2022-11-27T14:55:56Z',
          updated_at: '2022-11-27T14:55:56Z',
          secret: 'dVn4Rv8PuEazrCvYTQBjfpzY77XKjS5WMLl5mD40EL0'
        }
      }
    )
  end
  let(:customer_id) { '222222222222222222' }

  before do
    allow(Saltedge).to receive(:customers).and_return(remote_api)
    allow(remote_api).to receive(:create).and_return(process_result)
  end

  it 'calls saltedge api' do
    expect(result.success?).to eq true
    expect(remote_api).to have_received(:create)
  end

  it 'creates customer' do
    expect { result }.to change(Customer, :count).by(1)
    customer = user.customer
    expect(customer.saltedge_id).to eq(customer_id)
  end
end
