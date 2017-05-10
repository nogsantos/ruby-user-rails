Rails.application.routes.draw do  
  
  namespace :v1 do
    resources :users
  end
  namespace :v1 do
    resources :auths
  end
    
  root :to => "home#index"
end
