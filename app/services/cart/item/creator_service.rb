# frozen_string_literal: true

class Cart
  class Item
    class CreatorService < ApplicationService
      def initialize(cart, item_params)
        @cart = cart
        @item_params = item_params
        super
      end

      # rubocop:disable Metrics/AbcSize
      def call
        return response.add_error(:cart_not_present, message: "Cart not present") if cart.nil?
        return response.add_error(:product_not_found, message: "Product not found") if product.nil?

        if update_item
          response.result = item
          update_cart
        else
          response.errors = item.errors.messages
        end

        response
      end
      # rubocop:enable Metrics/AbcSize

      private

      attr_reader :cart, :item_params

      # TODO: ajustar depois
      # rubocop:disable Metrics/AbcSize
      def update_item
        item.product_id = product.id
        item.unit_price = product.price
        item.quantity = item_params[:quantity]
        item.total_price = item.unit_price * item.quantity
        item.save
      end
      # rubocop:enable Metrics/AbcSize

      def update_cart
        cart.abandoned_at = nil
        cart.total_price = cart.items.sum(:total_price).to_f
        cart.save
      end

      def item
        @item ||= @cart.items.find_or_initialize_by(product: product)
      end

      def product
        @product ||= Product.find_by(id: item_params[:product_id])
      end
    end
  end
end
