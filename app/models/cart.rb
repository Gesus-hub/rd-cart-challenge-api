# frozen_string_literal: true

class Cart < ApplicationRecord
  include Discard::Model

  has_many :cart_items, class_name: "Cart::Item", dependent: :destroy
  has_many :products, through: :cart_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end
