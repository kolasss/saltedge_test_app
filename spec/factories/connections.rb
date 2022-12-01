FactoryBot.define do
  factory :connection do
    customer
    sequence :saltedge_id do |n|
      "qwe#{n}"
    end
  end
end
