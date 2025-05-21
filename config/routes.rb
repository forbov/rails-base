Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: "users/confirmations",
                                    registrations: "users/registrations",
                                    sessions: "users/sessions",
                                    invitations: "users/invitations" }

  get "users/:id" => "users#show", as: :user

  devise_scope :user do
    get "/sign-in" => "devise/sessions#new", :as => :login
  end

  resources :users, only: %i[index] do
    member do
      patch :lock_or_unlock
      patch :resend
      delete :destroy
      get :dashboard
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#welcome"
end
