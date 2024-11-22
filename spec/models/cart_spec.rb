# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:items).dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:cart) { create(:cart, items_count: 5) }

    it 'destroys associated items when the cart is destroyed' do
      expect { cart.destroy }.to change { Cart::Item.count }.by(0)
    end
  end

  describe 'total_price' do
    it 'calculates the total price based on associated items' do
      cart = create(:cart, items_count: 2)
      expected_total_price = cart.items.sum(&:total_price)

      expect(cart.total_price).to eq(expected_total_price)
    end
  end
end
