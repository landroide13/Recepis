Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get 'pages/home' => 'pages#home'

  # resources :recipes

  get '/recipes' => 'recipes#index'
  get 'recipes/:id' => 'recipes#show', as:'recipe'


end
