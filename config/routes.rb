Rails.application.routes.draw do
  
  # post routes for creating, updating, viewing, deleting instances of post and advertisement
  resources :posts
  
  resources :advertisements

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
