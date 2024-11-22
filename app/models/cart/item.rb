# frozen_string_literal: true

class Cart
  class Item < ApplicationRecord
    belongs_to :cart
    belongs_to :product
  end
end
