Rails.application.routes.draw do
  root 'home#index'
  get '/billing', to: 'billing#show'
  devise_for :users, controllers: { invitations: 'users/invitations', registrations: "users/registrations" }
  scope :user do
    resource :tenants, only: [:update]
  end
  resource :account, only: [:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 # mount StripeEvent::Engine, at: '/webhooks/stripe', via: :post
end
