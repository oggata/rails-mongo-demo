Rails.application.routes.draw do


  get "/about"  => 'supports#about'
  get "/policy"  => 'supports#policy'
  get "/contact"  => 'supports#contact'
  resources :tags
  resources :words
  devise_for :users
  resources :sites
  resources :comments
  resources :articles
  resources :words

  root to: 'articles#index'
  get "/list/:tag/:page"   => "lists#articles",   as: :id, constraints: { tag: /\S+/,page: /\d+/ }
  get "/:id"           => "articles#show",      as: :article_id, constraints: { id: /\S+/ }

end
