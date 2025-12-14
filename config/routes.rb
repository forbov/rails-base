Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: "users/confirmations",
                                    registrations: "users/registrations",
                                    sessions: "users/sessions",
                                    invitations: "users/invitations" }

  get "users/:id" => "users#show", as: :user
  get "/otp_entry" => "home#otp_entry", as: :otp_entry
  post "/verify_otp" => "home#verify_otp", as: :verify_otp

  devise_scope :user do
    get "/sign-in" => "devise/sessions#new", :as => :login
  end

  resources :users, only: %i[index] do
    member do
      patch :lock_or_unlock
      patch :resend
      delete :destroy
      get :dashboard
      patch :enable_otp
      patch :disable_otp
      patch :issue_api_token
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

  mount MissionControl::Jobs::Engine, at: "/jobs"
end
