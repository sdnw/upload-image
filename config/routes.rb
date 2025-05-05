# Rails.application.routes.draw do
#   resources :pictures
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
#   # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
#   # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

#   # Defines the root path route ("/")
#   # root "posts#index"
#   # config/routes.rb

#   resources :pictures do
#     collection do
#       get :export
#     end
#   end

# end

# config/routes.rb
Rails.application.routes.draw do
  resources :pictures do
    collection do
      # Bulk-export route (no default CSV on /pictures)
      get :export_all
    end

    member do
      # Per-picture export
      get :export, defaults: { format: :csv }
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end

