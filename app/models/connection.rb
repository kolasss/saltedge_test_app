class Connection < ApplicationRecord
  belongs_to :customer
  has_many :accounts, dependent: :destroy

  validates :saltedge_id, presence: true, uniqueness: true
end
