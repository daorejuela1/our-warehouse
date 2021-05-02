Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { invitations: 'users/invitations', registrations: "users/registrations" }

  resource :account, only: [:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
