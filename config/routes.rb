Rails.application.routes.draw do
  root to: "users#index"

  resources :users, only: [:index, :edit, :update, :destroy, :new, :create]

  get 'verify_user', to: 'user_verifications#new'

  post 'verify_user', to: 'user_verifications#create'
end
