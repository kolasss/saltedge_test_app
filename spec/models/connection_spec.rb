require 'rails_helper'

RSpec.describe Connection, type: :model do
  subject { build(:connection) }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:accounts).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:saltedge_id) }
  it { is_expected.to validate_uniqueness_of(:saltedge_id) }
end
