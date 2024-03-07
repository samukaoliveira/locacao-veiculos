Rails.application.routes.draw do
  get 'login_admin', to: 'login_admin#login'
  post 'login_admin', to: 'login_admin#logar'
  resources :admins
  resources :clientes do
    resources :enderecos
    resources :reservas
  end
  resources :veiculos
  resources :marcas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'home', to: 'home#index'
end
