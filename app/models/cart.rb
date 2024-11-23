# frozen_string_literal: true

class Cart < ApplicationRecord
  include Discard::Model

  has_many :items, dependent: :destroy
end
