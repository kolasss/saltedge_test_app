FactoryBot.define do
  factory :account do
    connection
    sequence :saltedge_id do |n|
      "qwe#{n}"
    end
  end
end
