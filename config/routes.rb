# config/routes.rb
require 'sidekiq/web'               # Sidekiq’s Sinatra-based Web UI :contentReference[oaicite:0]{index=0}
require 'letter_opener_web'         # Letter Opener Web UI for previewing mails :contentReference[oaicite:1]{index=1}

Rails.application.routes.draw do
  # Mount Sidekiq Web UI at /sidekiq
  mount Sidekiq::Web => '/sidekiq'  # accessible at http://localhost:3000/sidekiq :contentReference[oaicite:2]{index=2}

  # Mount LetterOpenerWeb only in development for email previews
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'  # browse sent emails at /letter_opener :contentReference[oaicite:3]{index=3}
  end

  resources :pictures do
    collection do
      post :email_csv    # POST /pictures/email_csv → PicturesController#email_csv
      get  :export_all   # GET  /pictures/export_all(.:format) → PicturesController#export_all
    end

    member do
      # GET /pictures/:id/export.csv → PicturesController#export
      get :export, defaults: { format: :csv }
    end
  end

  # Health check endpoint
  get 'up', to: 'rails/health#show', as: :rails_health_check
end
