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
  get "/list/:tag"           => "lists#articles",   as: :id, constraints: { tag: /\S+/ }
  get "/:id"           => "articles#show",      as: :article_id, constraints: { id: /\S+/ }
  get "/about"  => 'supports#about'
  get "/policy"  => 'supports#policy'
  get "/contact"  => 'supports#contact'
end
