Rails.application.routes.draw do
  get 'loja/index', to: 'loja#index'
  root 'loja#index'
  get 'login_admin', to: 'login_admin#login'
  post 'logar_admin', to: 'login_admin#logar'
  get 'logout_admin', to: 'login_admin#logout'
  get 'recovery_admin', to: 'login_admin#admin_recovery'
  post 'recovery_send', to: 'login_admin#recovery_send'
  resources :admins
  get 'admins_initial', to: 'admins#initial'
  resources :reservas, only: [:index, :show]
  resources :clientes do
    resources :enderecos
  end
  get 'login_cliente', to: 'login_cliente#cliente_login'
  post 'logar_cliente', to: 'login_cliente#cliente_logar'
  get 'logout_cliente', to: 'login_cliente#cliente_logout'
  get 'recovery_cliente', to: 'login_cliente#cliente_recovery'
  post 'recovery_send', to: 'login_cliente#recovery_send'
  resources :reservas
  resources :veiculos
  resources :marcas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'home', to: 'home#index'
end
