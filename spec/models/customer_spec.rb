require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { build(:customer) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:connections).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:saltedge_id) }
  it { is_expected.to validate_uniqueness_of(:saltedge_id) }
end
