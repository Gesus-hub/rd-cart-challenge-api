# frozen_string_literal: true

module Carts
  class ItemsController < ApplicationController
    def create
      if cart_item_creator_service.ok?
        render json: data_serializer(cart_item_creator_service.result), status: :created
      else
        render json: { errors: cart_item_creator_service.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if item
        item.destroy
        render json: data_serializer(cart), status: :ok
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
      @cart ||= Cart.find_or_create_by(discarded_at: nil, finished_at: nil)
    end

    def items
      @items ||= cart.items
    end

    def item
      items.find_by(product_id: params[:id])
    end
  end
end
