# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Products API', openapi_spec: 'api/swagger.json' do
  path '/products' do
    get 'Retrieves all products' do
      tags 'Products'
      consumes 'application/json'
      produces 'application/json'

      response '200', 'products found' do
        let(:products) { create_list(:product, 3) }

        run_test!
      end
    end
  end

  path '/products/{id}' do
    get 'Retrieves a specific product by id' do
      tags 'Products'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Product ID'

      response '200', 'product found' do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          price: { type: :number },
          created_at: { type: :string, format: 'date-time' },
          updated_at: { type: :string, format: 'date-time' }
        }

        let!(:product) { create(:product) }
        let(:id) { product.id }

        run_test!
      end
    end
  end

  path '/products' do
    post 'Creates a new product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, required: true, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number }
        },
        required: %w[name price]
      }

      response '201', 'product created' do
        let(:product) { { name: 'Product A', price: 100.0 } }

        run_test!
      end
    end
  end

  path '/products/{id}' do
    put 'Updates a product by ID' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Product ID'
      parameter name: :product, in: :body, required: true, schema: {
        type: :object,
        properties: {
          name: { type: :string, description: 'The name of the product' },
          price: { type: :number, description: 'The price of the product' }
        }
      }

      response '200', 'product updated' do
        let(:product) { create(:product) }
        let(:id) { product.id }
        let(:updated_params) { { name: 'Updated Product', price: 150.0 } }

        run_test!
      end
    end
  end
end
