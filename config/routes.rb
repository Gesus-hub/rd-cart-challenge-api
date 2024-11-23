# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  get "up" => "rails/health#show", as: :rails_health_check
  root "rails/health#show"

  resources :products

  resource :cart do
    resources :items, only: %i[create destroy], module: :carts
  end
end
