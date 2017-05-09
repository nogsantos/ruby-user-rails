Rails.application.routes.draw do  
  
  resources :expense_groups
  resources :users, only: [:index, :create, :update, :show, :destroy]
  
  root :to => "home#index"
end
