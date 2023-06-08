Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      get '/users/:id/subscriptions', to: 'users/subscriptions#index'
      post '/users/:id/subscriptions', to: 'users/subscriptions#create'
      patch '/users/:id/subscriptions', to: 'users/subscriptions#update'
    end
  end
end
