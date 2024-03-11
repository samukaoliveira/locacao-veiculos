class LoginClienteController < ApplicationController
  layout 'loja'
  skip_before_action :verify_authenticity_token, only: :logar
  def cliente_login
  end

  def cliente_logar
    cliente = Cliente.login(params[:email], params[:password])
    if cliente.present?
      cookies[:cliente] = cliente.nome
      redirect_to clientes_path
    else
      flash[:alert] = 'Login falhou. Verifique suas credenciais.'
      render :cliente_login
    end
  end

  def cliente_logout
    cookies[:cliente] = nil
    redirect_to '/login_cliente'
  end

  def cliente_recovery
  end

  def recovery_send
    email = params[:email]
    if email.present?
    redirect_to login_cliente_path, notice: "Email enviado para #{email}"
    end
  end
end
