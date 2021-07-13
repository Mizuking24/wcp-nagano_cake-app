Rails.application.routes.draw do
  devise_for :customers

  root to: "homes#top"
  get "/about" => "homes#about"

  get "customers/withdraw" => "customers#withdraw"
  patch "customers/unsubscribe" => "customers#unsubscribe"

  delete "cart_items/destroy_all" => "cart_items#destroy_all"

  resources :items, only:[:index, :show]
  resources :customers, only:[:show, :edit, :update]
  resources :cart_items, only:[:index, :update, :destroy, :create]



end
