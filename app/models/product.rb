# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model

  has_many :cart_items, class_name: "Cart::Item", dependent: :destroy
  has_many :carts, through: :cart_items

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
