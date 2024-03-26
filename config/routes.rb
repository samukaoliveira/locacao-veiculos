Rails.application.routes.draw do
  resources :unidades
  get 'loja/index', to: 'loja#index'
  get 'loja/veiculo/:id', to: 'loja#veiculo', as: 'loja_veiculo'
  get 'loja/aluguel/:id', to: 'loja#aluguel', as: 'loja_aluguel'
  get 'loja/locacao/:id', to: 'loja#locacao', as: 'loja_locacao'
  get 'loja/pagamento/:id', to: 'loja#pagamento', as: 'loja_pagamento'
  post 'loja/confirma_pagto/:id', to: 'loja#confirma_pagto', as: 'loja_confirma_pagto'
  root 'loja#index'
  get 'login_admin', to: 'login_admin#login'
  post 'logar_admin', to: 'login_admin#logar'
  get 'logout_admin', to: 'login_admin#logout'
  get 'recovery_admin', to: 'login_admin#admin_recovery'
  post 'recovery_send', to: 'login_admin#recovery_send'
  resources :admins do
    collection do
      get 'cliente', to: 'admins#cliente'
      get 'clientes', to: 'admins#clientes_index'
      get 'initial', to: 'admins#initial'
      get 'reservas', to: 'admins#reservas'
      get 'reservas/:id/edit', to: 'reservas#edit', as: 'edit_reserva'
      get 'reservas/:id', to: 'reservas#destroy', as: 'destroy_reserva'
    end
  end
  resources :clientes do
    resources :enderecos
    get 'reservas/:id', to: 'reservas#show', as: 'reserva_show'
    get 'pagamento/:id', to: 'loja#pagamento', as: 'loja_pagamento'
  end
  get 'login_cliente', to: 'login_cliente#cliente_login'
  post 'logar_cliente', to: 'login_cliente#cliente_logar'
  get 'logout_cliente', to: 'login_cliente#cliente_logout'
  get 'recovery_cliente', to: 'login_cliente#cliente_recovery'
  post 'cliente_recovery_send', to: 'login_cliente#cliente_recovery_send'
  post 'cadastrar_reserva', to: 'reservas#create'
  get 'reservas', to: 'reservas#index'
  resources :veiculos
  resources :marcas
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'home', to: 'home#index'
  get 'unidades_busca', to: 'unidades#unidades_busca'
end
