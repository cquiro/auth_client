Rails.application.routes.draw do
  root to: "users#index"

  resources :users, only: [:index, :edit, :update, :destroy, :new, :create]
end
