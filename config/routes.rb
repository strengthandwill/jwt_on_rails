Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post 'auth_application' => 'authentication#authenticate_application'
  get 'home' => 'home#index'
end