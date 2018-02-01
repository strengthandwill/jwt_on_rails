Rails.application.routes.draw do
  get 'home' => 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end