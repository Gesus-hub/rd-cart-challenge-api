# frozen_string_literal: true

class CartSerializer
  def initialize(resource)
    @resource = resource
  end

  def serializable_hash
    return if resource.blank?
    return hash_for_collection if resource.is_a?(Enumerable)

    hash_for_one_record(resource)
  end

  private

  attr_reader :resource

  def hash_for_collection
    resource.map { |cart| hash_for_one_record(cart) }
  end

  def hash_for_one_record(cart)
    {
      id: cart.id,
      products: products_for_cart(cart),
      total_price: cart.items.sum(:total_price).to_s,
      discarded_at: cart.discarded_at,
      abandoned_at: cart.abandoned_at,
      finished_at: cart.finished_at,
      created_at: cart.created_at,
      updated_at: cart.updated_at
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
