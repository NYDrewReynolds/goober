Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  get '/dashboard', to: 'users#show'

  get '/new-driver', to: 'users#new_driver'
  post '/new-driver', to: 'users#create_driver'

  get '/new-rider', to: 'users#new_rider'
  post '/new-rider', to: 'users#create_rider'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
