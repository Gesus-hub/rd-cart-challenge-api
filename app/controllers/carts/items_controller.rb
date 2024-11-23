# frozen_string_literal: true

module Carts
  class ItemsController < ApplicationController
    def create
      if cart_item_creator_service.ok?
        render json: cart_item_creator_service.result, status: :created
      else
        render json: { errors: cart_item_creator_service.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if item
        item.destroy
        render json: formatted_cart, status: :ok
      else
        render json: { errors: "Item not found in cart" }, status: :not_found
      end
    end

    private

    def item_params
      params.required(:item).permit(:product_id, :quantity)
    end

    def cart_item_creator_service
      @cart_item_creator_service ||= Cart::Item::CreatorService.call(cart, item_params)
    end

    def cart
      @cart ||= Cart.find_or_create_by(discarded_at: nil)
    end

    def items
      @items ||= cart.items
    end

    def item
      items.find_by(product_id: params[:id])
    end

    # TODO: criar serializer
    # rubocop:disable Metrics/AbcSize
    def formatted_cart
      {
        id: cart.id,
        products: cart.items.map do |item|
          {
            id: item.product.id,
            name: item.product.name,
            quantity: item.quantity,
            unit_price: item.unit_price.to_s,
            total_price: item.total_price.to_s
          }
        end,
        total_price: cart.items.sum(:total_price).to_s
      }
    end
    # rubocop:enable Metrics/AbcSize
  end
end
