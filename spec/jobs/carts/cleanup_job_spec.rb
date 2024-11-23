# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Carts::CleanupJob do
  let!(:active_cart) { create(:cart, updated_at: 2.hours.ago) }
  let!(:abandoned_cart) { create(:cart, abandoned_at: nil) }
  let!(:old_abandoned_cart) { create(:cart, abandoned_at: 8.days.ago) }

  before do
    abandoned_cart.update!(updated_at: 4.hours.ago)
  end

  it 'marks carts as abandoned if inactive for more than 3 hours' do
    expect { described_class.perform_now }
      .to change { abandoned_cart.reload.abandoned_at }.from(nil).to(be_present)
  end

  it 'discards carts abandoned for more than 7 days' do
    expect { described_class.perform_now }
      .to change { old_abandoned_cart.reload.discarded? }.from(false).to(true)
  end

  it 'does not mark active carts as abandoned' do
    expect { described_class.perform_now }
      .not_to(change { active_cart.reload.abandoned_at })
  end
end
