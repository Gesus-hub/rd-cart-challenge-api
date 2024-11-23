# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    discarded_at { nil }

    after(:create) do |cart, evaluator|
      cart_items = create_list(:cart_item, evaluator.items_count || 3, cart: cart)
      cart.update!(total_price: cart_items.sum(&:total_price))
    end

    transient do
      items_count { 3 }
    end
  end
end
