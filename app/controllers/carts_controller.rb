# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    render json: formatted_cart
  end

  def update
    cart.total_price = cart.items.sum(:total_price).to_f
    cart.save

    render json: formatted_cart
  end

  def destroy
    cart.discard
  end

  private

  def cart
    @cart ||= Cart.find_or_create_by(discarded_at: nil)
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
