Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'reservations', to: 'reservations#create'
      patch 'reservations/:id', to: 'reservations#update'
      get 'reservations/:id', to: 'reservations#show'
    end
  end
end