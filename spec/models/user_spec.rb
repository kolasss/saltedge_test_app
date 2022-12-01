require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one(:customer).dependent(:destroy) }
  it { is_expected.to have_many(:connections).through(:customer) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_confirmation_of(:password) }
end
