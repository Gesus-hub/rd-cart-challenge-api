# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).class_name('Cart::Item').dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:cart_items) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
  end
end
