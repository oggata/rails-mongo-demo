Rails.application.routes.draw do
  resources :tags
  resources :words
  devise_for :users
  resources :sites
  resources :comments
  resources :articles
  resources :words
  #resources :cats
  root to: 'articles#index'

  get "/lists"  => 'lists#articles'

  get "/about"  => 'supports#about'
  get "/policy"  => 'supports#policy'
  get "/contact"  => 'supports#contact'
  #get "/jp"           => "articles#index"
  #get "/en"           => "articles#index"
  #get "/en/articles/:id"           => "articles#show"
  #get "/jp/articles/:id"           => "articles#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
