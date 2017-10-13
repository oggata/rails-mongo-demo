Rails.application.routes.draw do
  resources :comments
  resources :articles
  resources :cats
  root to: 'articles#index'
  #get "/jp/articles/:id"           => "articles#show",       as: :article_id
  #get "/en/articles/:id"           => "articles#show",       as: :article_id
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
