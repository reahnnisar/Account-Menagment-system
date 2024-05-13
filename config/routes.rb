Rails.application.routes.draw do
  root "entries#sum"
  resources :entries, except: [:destroy]
  get '/entries/:id/destroy' => 'entries#destroy', as: :destroy_entry 
end
