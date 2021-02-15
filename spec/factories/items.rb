FactoryBot.define do
  factory :item do
    name { Faker::Coffee.blend_name }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Number.decimal(r_digits: 2) }
    association :merchant
  end
end
