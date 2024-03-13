class LoginClienteController < ApplicationController
  layout 'loja'
  skip_before_action :verify_authenticity_token, only: :logar
  before_action :store_location, only: [:new, :edit]
  def cliente_login
  end

  def cliente_logar
    cliente = Cliente.login(params[:email], params[:password])
    if cliente.present?
      cookies[:cliente] = cliente.nome
      destino = session[:return_to] || root_path
      debugger
      redirect_to destino
    else
      redirect_to login_cliente_path, notice: "Email e/ou senha inválidos"
    end
  end

  def cliente_logout
    cookies[:cliente] = nil
    redirect_to '/login_cliente'
  end

  def cliente_recovery
  end

  def cliente_recovery_send
    email = params[:email]
    if email.present?
      redirect_to login_cliente_path, notice: "Email enviado para #{email}"
    end
  end

  private

  def store_location
    session[:return_to] = request.referer if request.get?
  end

  def redirect_back_or_default
    redirect_to session.delete(:return_to) || root_path
  end
end
