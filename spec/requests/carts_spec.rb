# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts' do
  describe 'GET /cart' do
    context 'when the user is authenticated' do
      let!(:cart) { create(:cart) }

      it 'returns HTTP status :ok (200) and shows the current cart' do
        get '/cart'

        expected_body = {
          data: {
            id: cart.id,
            products: cart.items.map do |cart_item|
              {
                id: cart_item.product.id,
                name: cart_item.product.name,
                quantity: cart_item.quantity,
                unit_price: cart_item.unit_price.to_s,
                total_price: cart_item.total_price.to_s
              }
            end,
            total_price: cart.total_price.to_s,
            discarded_at: cart.discarded_at.as_json,
            abandoned_at: cart.abandoned_at.as_json,
            finished_at: cart.finished_at.as_json,
            created_at: cart.created_at.as_json,
            updated_at: cart.updated_at.as_json
          }
        }

        expect(response).to have_http_status(:ok)
        expect(json(response.body)).to eq(expected_body)
      end
    end
  end

  describe 'PUT /cart' do
    context 'when the user is authenticated' do
      let!(:cart) { create(:cart) }

      it 'returns HTTP status :ok (200) and updates the cart total price' do
        put '/cart'

        expected_body = {
          data: {
            id: cart.id,
            products: cart.items.map do |cart_item|
              {
                id: cart_item.product.id,
                name: cart_item.product.name,
                quantity: cart_item.quantity,
                unit_price: cart_item.unit_price.to_s,
                total_price: cart_item.total_price.to_s
              }
            end,
            total_price: cart.total_price.to_s,
            discarded_at: cart.discarded_at.as_json,
            abandoned_at: cart.abandoned_at.as_json,
            finished_at: cart.finished_at.as_json,
            created_at: cart.created_at.as_json,
            updated_at: cart.updated_at.as_json
          }
        }

        expect(response).to have_http_status(:ok)
        expect(json(response.body)).to eq(expected_body)
      end
    end
  end

  describe 'DELETE /cart' do
    context 'when the user is authenticated' do
      let!(:cart) { create(:cart) }

      it 'returns HTTP status :no_content (204) and deletes the cart' do
        delete '/cart'

        expect(response).to have_http_status(:no_content)
        expect(cart.reload.discarded?).to be true
      end
    end
  end
end
