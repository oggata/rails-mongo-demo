Rails.application.routes.draw do

  #devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  #@user = current_user
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  get "/about"  => 'supports#about'
  get "/policy"  => 'supports#policy'
  get "/contact"  => 'supports#contact'
  resources :tags
  resources :words
  resources :sites
  resources :comments
  resources :articles
  resources :words

  root to: 'articles#index'
  get "/list/:tag/:page"   => "lists#articles",   as: :id, constraints: { tag: /\S+/,page: /\d+/ }
  get "/:id"           => "articles#show",      as: :article_id, constraints: { id: /\S+/ }

end
