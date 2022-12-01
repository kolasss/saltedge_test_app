class Customer < ApplicationRecord
  belongs_to :user
  has_many :connections, dependent: :destroy

  validates :saltedge_id, presence: true, uniqueness: true
end
