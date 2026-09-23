Rails.application.routes.draw do
  root "posts#index"

  resources :users, only: %i[new create show]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :posts do
    resources :comments, only: %i[create destroy]
    resource :like, only: %i[create destroy]
    collection do
      get :search
    end
  end

  post "ai/improve_post", to: "ai#improve_post"

  resource :profile, only: %i[show edit update]

  get "password_reset", to: "password_resets#new", as: :new_password_reset
  post "password_reset", to: "password_resets#create", as: :password_reset
  get "password_reset/edit", to: "password_resets#edit", as: :edit_password_reset
  patch "password_reset", to: "password_resets#update"
end
