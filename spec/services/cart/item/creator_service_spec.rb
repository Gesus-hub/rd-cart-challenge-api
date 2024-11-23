# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart::Item::CreatorService do
  describe '#call' do
    subject { described_class.call(cart, item_params) }

    context 'when the params are valid' do
      let(:cart) { create(:cart) }
      let(:product) { create(:product) }
      let(:item_params) { { product_id: product.id, quantity: 3 } }

      it 'returns ok? true and save item to cart' do
        expect(subject).to be_ok
        expect(subject.result[:products].count).to eq(4)
        expect(subject.result[:products].last[:name]).to eq(product.name)
        expect(subject.result[:total_price]).to eq(cart.total_price + (product.price * item_params[:quantity]))
      end
    end

    context 'when the cart is nil' do
      let(:cart) { nil }
      let(:item_params) { { product_id: 1, quantity: 3 } }

      it 'returns an error for cart_not_present' do
        expect(subject).not_to be_ok
        expect(subject.errors.first.type).to eq(:cart_not_present)
        expect(subject.errors.first.options[:message]).to eq('Cart not present')
      end
    end

    context 'when the product is not found' do
      let(:cart) { create(:cart) }
      let(:item_params) { { product_id: 9999, quantity: 3 } }

      it 'returns an error for product_not_found' do
        expect(subject).not_to be_ok
        expect(subject.errors.first.type).to eq(:product_not_found)
        expect(subject.errors.first.options[:message]).to eq('Product not found')
      end
    end

    context 'when the item params are invalid' do
      let(:cart) { create(:cart) }
      let(:item_params) { { product_id: nil, quantity: nil } }

      it 'returns an error for invalid item parameters' do
        expect(subject).not_to be_ok
        expect(subject.errors.first.type).to eq(:product_not_found)
        expect(subject.errors.first.options[:message]).to eq('Product not found')
      end
    end
  end
end
