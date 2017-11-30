Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'pages/home' => 'pages#home'

  resources :recipes do
    resources :coments, only:[:create]
  end 

  get '/signup' => 'chefs#new'
  resources :chefs, except: [:new]
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :ingredients, except: [:destroy]

  mount ActionCable.server => '/cable'


end
