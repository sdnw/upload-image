# config/routes.rb
require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  resources :pictures do
    collection do
      # Bulk-export route (no default CSV on /pictures)
      post :email_csv
      get :export_all
    end

    member do
      # Per-picture export
      get :export, defaults: { format: :csv }
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
