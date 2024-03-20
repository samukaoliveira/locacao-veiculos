class LojaController < ClientesController
include HTTParty
  before_action :set_veiculo, except: [ :index, :pagamento ] 
  before_action :set_cliente_cookie
  after_action :capturar_destino
  before_action :authenticate_user!, only: %i[ aluguel locacao pagamento ]
  before_action :set_token_pagamento, only: %i[ aluguel locacao pagamento ]
  before_action :set_reserva, only: %i[ pagamento ]

  def index
    partida = params[:partida]
    dt_partida = params[:dt_partida]
    hr_partida = params[:hr_partida]

    session[:parametros] = [
      partida: partida,
      dt_partida: dt_partida,
      hr_partida: hr_partida
    ]
    
    #faz o tratamento do perfil
    
      #verifica se foi passado algum parâmetro de pesquisa
      if partida.present?
        @veiculos = Veiculo.where(status: :disponivel).where(unidade_id: partida)
      elsif partida.present? && dt_partida.present?
        @veiculos = Veiculo.includes(:reservas).where(unidade_id: dt_partida).where(dt_final: dt_partida).where(hr_final: hr_partida - 12.hours)
      else
        @veiculos = Veiculo.where(status: :disponivel)
      end

  end

  def veiculo
    
  end

  def aluguel
    @reserva = Reserva.new
    @parametros = session[:parametros]
    unless @parametros.first["partida"].blank?
      @unidade_partida = Unidade.find(@parametros.first["partida"].to_i)
    else
      redirect_to root_path, notice: "Escolha uma data."
    end
  end

  def locacao
  end

  def pagamento
  end

  private

    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    def set_cliente
      @cliente = Cliente.find(params[:cliente_id])
    end

    def set_token_pagamento
      email = "mucabatera@gmail.com"
      token = "F8FB79C9D33147D2B3F669C7F26BFA3F"
      app_id = "samcar"
      app_key = "9FA90B4EC8C829D444D89F806C3D230B"
      response = HTTParty.post("https://ws.sandbox.pagseguro.uol.com.br/v2/sessions?email=#{email}&token=#{token}")
      if (200..299).include?(response.code)
        @session_id = response.parsed_response["session"]["id"]
      end
    end

    def capturar_destino
      session[:return_to] = request.fullpath
    end

    def set_veiculo
      @veiculo = Veiculo.find(params[:id])
      cookies[:veiculo] = [ id: @veiculo.id ]
    end
    
    def set_cliente_cookie
      if cookies[:cliente].present?
        cliente_info = JSON.parse(cookies[:cliente])
        cliente_id = cliente_info['id']
        @cliente = Cliente.find(cliente_id)
      end
    end

end