# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart::Item do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end
end
