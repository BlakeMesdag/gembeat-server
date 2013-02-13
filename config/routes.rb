GembeatServer::Application.routes.draw do
  resources :applications
  resources :pulse, :only => [:create]

  root :to => "applications#index"
end
