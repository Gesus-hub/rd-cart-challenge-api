# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts::ItemsController Routes' do
  describe 'routes' do
    it 'routes to #create' do
      expect(post: '/cart/items').to route_to('carts/items#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/cart/items/:id').to route_to('carts/items#destroy', id: ':id')
    end
  end
end
