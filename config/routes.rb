Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }
  # 管理者のダッシュボード用のルーティング
  namespace :admins do
    get "dashboard", to: "dashboard#index"
    resources :users
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "memories#top"

  resources :albums, only: %i[index new create show edit update destroy] do
    resources :photos, only: %i[new create destroy]
    get "edit_photos", to: "photos#edit_multiple", as: :edit_photos
    patch "update_photos", to: "photos#update_multiple", as: :update_photos
  end
  # letter_opener_webの設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
