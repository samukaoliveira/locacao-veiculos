class LoginAdminController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :logar
  def login
  end

  def logar
    admin = Admin.login(params[:email], params[:password])
    if admin.present?
      cookies[:admin] = admin.nome
      redirect_to '/admins'
    end
  end

  def logout
    cookies[:admin] = nil
    redirect_to '/login_admin'
  end

  def admin_recovery
  end

  def recovery_send
    email = params[:email]
    if email.present?
    redirect_to login_admin_path, notice: "Email enviado para #{email}"
    end
  end
end
