require 'rails_helper'

RSpec.describe Provider, type: :model do
  subject { build(:provider) }

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
end
