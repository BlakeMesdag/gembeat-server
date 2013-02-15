GembeatServer::Application.routes.draw do
  match '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  resources :applications
  resources :pulse, :only => [:create]
  resources :dependencies, :only => [:index, :show]

  root :to => "applications#index"
end
