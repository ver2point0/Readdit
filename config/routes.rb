Rails.application.routes.draw do
  
  resources :questions

  # post routes for creating, updating, viewing, deleting instances of post
  resources :posts

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
