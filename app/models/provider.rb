class Provider < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  # def mode
  #   data[:mode]
  # end
end
