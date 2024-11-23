# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item, class: 'Cart::Item' do
    cart
    product
    quantity { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Commerce.price(range: 5.0..100.0) }
    total_price { (quantity * unit_price).round(2) }
  end
end
