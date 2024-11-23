# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartsController Routes' do
  describe 'routes' do
    it 'routes to #show' do
      expect(get: '/cart').to route_to('carts#show')
    end

    it 'routes to #update' do
      expect(put: '/cart').to route_to('carts#update')
    end

    it 'routes to #destroy' do
      expect(delete: '/cart').to route_to('carts#destroy')
    end
  end
end
