FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:visa).delete('-') }
    result { 'success' }
  end
end