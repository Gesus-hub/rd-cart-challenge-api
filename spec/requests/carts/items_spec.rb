# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts::ItemsController' do
  let(:product) { create(:product) }
  let(:cart) { create(:cart) }

  describe 'POST /carts/items' do
    context 'when the request is valid' do
      it 'creates an item in the cart and returns status created' do
        post '/cart/items', params: { item: { product_id: product.id, quantity: 2 } }

        expect(response).to have_http_status(:created)
        expect(json(response.body)[:data][:id]).to eq(Cart.last.id)
        expect(json(response.body)[:data][:products].first[:id]).to eq(product.id)
        expect(json(response.body)[:data][:products].first[:quantity]).to eq(2)
      end
    end

    context 'when the request is invalid' do
      it 'returns an unprocessable entity error' do
        post '/cart/items', params: { item: { product_id: nil, quantity: 2 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json(response.body)[:errors]).to include("cart/item/creator_service": ["Product not found"])
      end
    end
  end

  describe 'DELETE /cart/items/:id' do
    context 'when the item exists' do
      it 'removes the item from the cart and returns the updated cart' do
        initial_total_price = cart.total_price.to_f
        product_to_delete = cart.items.first
        updated_total_price = initial_total_price - product_to_delete.total_price.to_f

        delete "/cart/items/#{product_to_delete.product_id}"

        expect(response).to have_http_status(:ok)
        expect(json(response.body)[:data][:products].count).to eq(2)
        expect(json(response.body)[:data][:total_price].to_f).to be_within(0.01).of(updated_total_price.to_f)
      end
    end

    context 'when the item does not exist' do
      it 'returns an error' do
        delete "/cart/items/999999"

        expect(response).to have_http_status(:not_found)
        expect(json(response.body)[:errors]).to eq("Item not found in cart")
      end
    end
  end
end
