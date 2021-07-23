Rails.application.routes.draw do
  devise_for :customers

  namespace :admin do
    devise_for :admins, path: "", controllers: {
        sessions: 'admin/admins/sessions',
        registrations: 'admin/admins/registrations',
        passwords: 'admin/admins/passwords'
      }
  end

# 管理者側
  get "/admin" => "admin/homes#top"

  namespace :admin do
    resources :items, only:[:index, :create, :new, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
  end


# 会員側
  root to: "homes#top"
  get "/about" => "homes#about"
  get "customers/withdraw" => "customers#withdraw"
  patch "customers/unsubscribe" => "customers#unsubscribe"
  delete "cart_items/destroy_all" => "cart_items#destroy_all"
  post "orders/info" => "orders#info"
  get "orders/thanks" => "orders#thanks"

  resources :items, only:[:index, :show]
  resources :customers, only:[:show, :edit, :update]
  resources :cart_items, only:[:index, :update, :destroy, :create]
  resources :addresses, only:[:index, :create, :edit, :update, :destroy]
  resources :orders, only:[:new, :create, :index, :show]

end
