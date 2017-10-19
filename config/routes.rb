Rails.application.routes.draw do
  resources :sites
  resources :comments
  resources :articles
  #resources :cats
  root to: 'articles#index'
  #get "/jp"           => "articles#index"
  #get "/en"           => "articles#index"
  #get "/en/articles/:id"           => "articles#show"
  #get "/jp/articles/:id"           => "articles#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
