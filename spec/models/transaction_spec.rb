require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { build(:transaction) }

  it { is_expected.to belong_to(:account) }

  it { is_expected.to validate_presence_of(:saltedge_id) }
  it { is_expected.to validate_uniqueness_of(:saltedge_id) }
end
