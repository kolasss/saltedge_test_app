FactoryBot.define do
  factory :transaction do
    account
    sequence :saltedge_id do |n|
      "qwe#{n}"
    end
  end
end
