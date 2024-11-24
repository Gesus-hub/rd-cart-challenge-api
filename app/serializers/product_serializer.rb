# frozen_string_literal: true

class ProductSerializer
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
    resource.map { |product| hash_for_one_record(product) }
  end

  def hash_for_one_record(product)
    {
      id: product.id,
      name: product.name,
      price: product.price,
      created_at: product.created_at,
      updated_at: product.updated_at
    }
  end
end
