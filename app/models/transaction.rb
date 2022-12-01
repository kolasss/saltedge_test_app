class Transaction < ApplicationRecord
  belongs_to :account

  validates :saltedge_id, presence: true, uniqueness: true
end
