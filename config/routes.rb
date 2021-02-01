Rails.application.routes.draw do
  root :to => "ideas#index"
  resources :ideas do
    resources :reviews, only:[:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only:[:new, :create, :edit, :update, :destroy]
  resource :session, only:[:new, :create, :destroy]
end
