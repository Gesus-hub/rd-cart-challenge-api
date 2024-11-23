# frozen_string_literal: true

module Carts
  class CleanupJob < ApplicationJob
    queue_as :default

    def perform
      Cart.where(abandoned_at: nil)
          .where(updated_at: ..3.hours.ago)
          .find_each do |cart|
        cart.update!(abandoned_at: Time.current)
      end

      Cart.where.not(abandoned_at: nil)
          .where(abandoned_at: ..7.days.ago)
          .find_each(&:discard)
    end
  end
end
