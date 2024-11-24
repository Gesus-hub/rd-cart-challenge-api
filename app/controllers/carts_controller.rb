# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    render json: data_serializer(cart)
  end

  def update
    cart.total_price = cart.items.sum(:total_price).to_f
    cart.save

    render json: data_serializer(cart)
  end

  def destroy
    cart.discard
  end

  private

  def cart
    @cart ||= Cart.find_or_create_by(discarded_at: nil, finished_at: nil)
  end
end
