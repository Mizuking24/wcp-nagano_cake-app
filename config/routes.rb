Rails.application.routes.draw do
  devise_for :customers
  root to: "homes#top"
  get "/about" => "homes#about"
  get "customers/withdraw" => "customers#withdraw"
  patch "customers/unsubscribe" => "customers#unsubscribe"

  resources :items, only:[:index, :show]
  resources :customers, only:[:show, :edit, :update]



end
