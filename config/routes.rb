Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  devise_for :admin, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  namespace :admin do
    get "/", to: "home#index", as: "home"
    resources :supplies
    resources :revenues
    resources :properties, expect: %i[create index update destroy new edit show]
    resources :animal_productions, expect: %i[create index update destroy new edit show]
    resources :production_modules, only: [:new, :create, :edit, :update, :destroy, :index, :show]
    resources :expenses, only: [:new, :create, :edit, :update, :destroy, :index, :show]
    resources :property_accesses, only: [:new, :create, :destroy]
    resources :finances, only: [:index]
    resources :statistics, only: [:index]
  end

  resources :tasks, only: [:new, :create, :show, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
