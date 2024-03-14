class LojaController < ClientesController
  before_action :set_veiculo, except: :index
  before_action :set_cliente_cookie
  after_action :capturar_destino
  before_action :authenticate_user!, only: %i[ aluguel locacao ]

  def index
    if params[:nome].present?
      @veiculos = Veiculo.where("lower (nome) ilike '%#{URI::encode_www_form_component(params[:nome])}%'")
    else
      @veiculos = Veiculo.all
    end
  end

  def veiculo
  end

  def aluguel
  end

  def locacao
  end

  private

    def capturar_destino
      session[:return_to] = request.fullpath
    end

    def set_veiculo
      @veiculo = Veiculo.find(params[:id])
    end
    
    def set_cliente_cookie
      if cookies[:cliente].present?
        cliente_info = JSON.parse(cookies[:cliente])
        cliente_id = cliente_info['id']
        @cliente = Cliente.find(cliente_id)
      end
    end

end