# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Carts API', openapi_spec: 'api/swagger.json' do
  path '/cart' do
    get 'Retrieves the current cart' do
      tags 'Carts'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'cart retrieved' do
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
                    name: { type: :string },
                    quantity: { type: :integer },
                    unit_price: { type: :string },
                    total_price: { type: :string }
                  }
                }
              },
              total_price: { type: :string },
              discarded_at: { type: :string, format: 'date-time', nullable: true },
              abandoned_at: { type: :string, format: 'date-time', nullable: true },
              finished_at: { type: :string, format: 'date-time', nullable: true },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            }
          }
        }

        let(:cart) { create(:cart) }

        run_test!
      end
    end
  end

  path '/cart' do
    delete 'Deletes the current cart' do
      tags 'Carts'
      produces 'application/json'

      response '204', 'cart deleted' do
        let(:cart) { create(:cart) }

        run_test!
      end
    end
  end
end
