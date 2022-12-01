class Account < ApplicationRecord
  belongs_to :connection
  has_many :transactions, dependent: :destroy

  validates :saltedge_id, presence: true, uniqueness: true
end
