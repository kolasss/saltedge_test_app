FactoryBot.define do
  factory :customer do
    user
    sequence :saltedge_id do |n|
      "qwe#{n}"
    end
  end
end
