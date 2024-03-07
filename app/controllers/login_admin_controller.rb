class LoginAdminController < ApplicationController
  def login
  end

  def logar
    admin = Admin.login[params[:login], params[:password]]
    if admin.present?
      coockies[:admin] = admin.nome
      redirect_to '/'
    end
  end
end
