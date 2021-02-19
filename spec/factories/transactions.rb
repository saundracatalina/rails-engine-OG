FactoryBot.define do
  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    credit_card_expiration_date {Faker::Date.forward(days: 365)}
    invoice
  end
end 
