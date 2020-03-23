FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { rand(100..99999) }
  end
end