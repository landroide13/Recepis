Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'pages/home' => 'pages#home'

  resources :recipes

  get '/signup' => 'chefs#new'
  resources :chefs, except: [:new]
  # get '/recipes' => 'recipes#index'
  # get '/recipes/new' => 'recipes#new', as:'new_recipe'
  # get '/recipes/:id' => 'recipes#show', as:'recipe'
  # post '/recipes' => 'recipes#create'




end
