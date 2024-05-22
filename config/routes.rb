Rails.application.routes.draw do
  root to: 'entries#sum'

  resources :users, except: [:new, :create]
  resources :entries, except: [:destroy]
  get '/entries/:id/destroy' => 'entries#destroy', as: :destroy_entry

  get "login" => "user_sessions#new", as: :login
  post "login" => "user_sessions#create"
  post "logout" => "user_sessions#destroy", as: :logout
end
