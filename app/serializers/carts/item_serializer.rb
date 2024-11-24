# frozen_string_literal: true

module Carts
  class ItemSerializer
    def initialize(resource)
      @resource = resource
    end

    def serializable_hash
      return if resource.blank?
      return hash_for_collection if resource.respond_to?(:each)

      hash_for_one_record(resource)
    end

    private

    attr_reader :resource

    def hash_for_collection
      resource.map { |cart| hash_for_one_record(cart) }
    end

    def hash_for_one_record(cart_item)
      {
        id: cart_item.cart.id,
        products: products_for_cart(cart_item.cart),
        total_price: cart_item.cart.total_price
      }
    end

    def products_for_cart(cart)
      cart.items.map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.unit_price.to_s,
          total_price: item.total_price.to_s
        }
      end
    end
  end
end
