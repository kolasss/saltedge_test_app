require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { build(:account) }

  it { is_expected.to belong_to(:connection) }
  it { is_expected.to have_many(:transactions).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:saltedge_id) }
  it { is_expected.to validate_uniqueness_of(:saltedge_id) }
end
