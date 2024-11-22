# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).class_name('Cart::Item').dependent(:destroy) }
    it { is_expected.to have_many(:carts).through(:cart_items) }
  end

  describe 'validations' do
    subject { build(:product) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    context 'when price is negative' do
      it 'is not valid and adds the appropriate error message' do
        product = build(:product, price: -1)
        expect(product).not_to be_valid
        expect(product.errors[:price]).to include('must be greater than or equal to 0')
      end
    end
  end
end
