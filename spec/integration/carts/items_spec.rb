# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Carts::Items API', openapi_spec: 'api/swagger.json' do
  path '/cart/items' do
    post 'Adds an item to the cart' do
      tags 'Cart Items'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :item, in: :body, required: true, schema: {
        type: :object,
        properties: {
          item: {
            type: :object,
            properties: {
              product_id: { type: :integer },
              quantity: { type: :integer }
            },
            required: %w[product_id quantity]
          }
        },
        required: ['item']
      }

      response '201', 'item added to the cart' do
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              id: { type: :integer },
              products: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    quantity: { type: :integer }
                  }
                }
              }
            }
          }
        }

        let(:product) { create(:product) }
        let(:item) { { item: { product_id: product.id, quantity: 2 } } }

        run_test!
      end

      response '422', 'unprocessable entity' do
        schema type: :object, properties: {
          errors: {
            type: :object,
            additionalProperties: { type: :array, items: { type: :string } }
          }
        }

        let(:item) { { item: { product_id: nil, quantity: 2 } } }

        run_test!
      end
    end
  end

  path '/cart/items/{id}' do
    delete 'Removes an item from the cart' do
      tags 'Cart Items'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, required: true, description: 'ID of the product in the cart'

      response '200', 'item removed from the cart' do
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              products: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    quantity: { type: :integer }
                  }
                }
              },
              total_price: { type: :string }
            }
          }
        }

        let(:cart) { create(:cart) }
        let(:id) { cart.items.first.product_id }

        run_test!
      end

      response '404', 'item not found in cart' do
        schema type: :object, properties: {
          errors: { type: :string }
        }

        let(:id) { 999_999 }

        run_test!
      end
    end
  end
end
