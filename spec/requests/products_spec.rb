# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products' do
  let(:product) { create(:product) }
  let(:valid_params) do
    {
      name: 'Product A',
      price: 100.0
    }
  end

  let(:invalid_params) do
    {
      price: -1
    }
  end

  describe 'GET /products' do
    it 'returns HTTP status :ok (200) and a list of products' do
      create(:product)
      get '/products'

      expect(response).to have_http_status(:ok)
      expect(json(response.body).count).to eq(1)
    end
  end

  describe 'GET /products/:id' do
    it 'returns HTTP status :ok (200) and a list of products' do
      product = create(:product)
      get "/products/#{product.id}"

      expected_body = {
        id: product.id,
        name: product.name,
        price: product.price.as_json,
        created_at: product.created_at.as_json,
        updated_at: product.updated_at.as_json
      }

      expect(response).to have_http_status(:ok)
      expect(json(response.body)).to eq(expected_body)
    end
  end

  describe 'POST /products' do
    context 'when the parameters are valid' do
      it 'returns HTTP status :created (201) and product' do
        post '/products', params: { product: valid_params }

        created_product = Product.find_by(
          name: valid_params[:name],
          price: valid_params[:price]
        )

        expect(response).to have_http_status(:created)
        expect(created_product).not_to be_nil
      end
    end

    context 'when the parameters are invalid' do
      it 'returns HTTP status :unprocessable_entity (422) with error message' do
        post '/products', params: { product: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json(response.body)).to eq(name: ["can't be blank"], price: ["must be greater than or equal to 0"])
      end
    end
  end

  describe 'PUT /products/:id' do
    context 'when the parameters are valid' do
      it 'returns HTTP status :ok (200) and updated product data' do
        put "/products/#{product.id}", params: { product: { price: 150.0 } }

        product.reload

        expected_body = {
          id: product.id,
          name: product.name,
          price: product.price.as_json,
          created_at: product.created_at.as_json,
          updated_at: product.updated_at.as_json
        }

        expect(response).to have_http_status(:ok)
        expect(json(response.body)).to eq(expected_body)
      end
    end

    context 'when the parameters are invalid' do
      it 'returns HTTP status :unprocessable_entity (422) and the errors' do
        put "/products/#{product.id}", params: { product: { price: -1 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json(response.body)).to eq(price: ["must be greater than or equal to 0"])
      end
    end
  end

  # describe 'DELETE /products/:id' do
  #   it 'deletes the product' do
  #     expect do
  #       delete "/products/#{product.id}"
  #     end.to change(Product, :count).by(-1)

  #     expect(response).to have_http_status(:no_content)
  #   end
  # end
end
