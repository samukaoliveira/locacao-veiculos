class LojaController < ClientesController
include HTTParty
  before_action :set_veiculo, except: :index
  before_action :set_cliente_cookie
  after_action :capturar_destino
  before_action :authenticate_user!, only: %i[ aluguel locacao ]
  before_action :set_token_pagamento, only: %i[ aluguel locacao ]

  def index
    partida = params[:partida]
    
    #faz o tratamento do perfil
    
      #verifica se foi passado algum parâmetro de pesquisa
      if partida.present?
        @veiculos = Veiculo.where(status: :disponivel).where(unidade_id: partida)
      else
        @veiculos = Veiculo.where(status: :disponivel)
      end

  end

  def veiculo
  end

  def aluguel
  end

  def locacao
  end

  private

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
    end
    
    def set_cliente_cookie
      if cookies[:cliente].present?
        cliente_info = JSON.parse(cookies[:cliente])
        cliente_id = cliente_info['id']
        @cliente = Cliente.find(cliente_id)
      end
    end

end