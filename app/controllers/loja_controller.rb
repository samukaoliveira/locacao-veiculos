class LojaController < ClientesController
include HTTParty
  before_action :set_veiculo, except: [ :index, :pagamento ] 
  before_action :set_cliente_cookie
  after_action :capturar_destino
  before_action :authenticate_user!, only: %i[ aluguel locacao pagamento ]
  before_action :set_token_pagamento, only: %i[ pagamento ]
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

    def confirma_pagamento
      email = "mucabatera@gmail.com"
      token_loja = "F8FB79C9D33147D2B3F669C7F26BFA3F"

      token_card = params[:token_card]
      qt_parcelas = params[:qt_parcelas]
      valor_total_parcelado = params[:valor_total_parcelado]
      cartao_nome = params[:cartao_nome]
      cartao_cpf = params[:cartao_cpf]
      cartao_ddd = params[:cartao_ddd]
      cartao_phone = params[:cartao_phone]
      cartao_dt_nasc = params[:cartao_dt_nasc]
      valor_total_parcelado = params[:valor_total_parcelado]
      valor_aluguel = params[:valor_aluguel]

      body = {
        paymentMode: "default",
        paymentMethod: "creditCard",
        receiverEmail: "mucabatera@gmail.com",
        currency: "BRL",
        extraAmount: "0.00",
        itemId1: "0001",
        itemDescription1: "Aluguel - #{@veiculo.nome}",
        itemAmount1: valor_aluguel,
        itemQuantity1: "1",
        notificationURL: "https://sualoja.com.br/notifica.html",
        reference: "REF1234",
        senderName: @cliente.nome,
        senderCPF: @cliente.cpf,
        senderAreaCode: @cliente.telefone,
        senderPhone: @cliente.telefone,
        senderEmail: @cliente.email,
        senderHash: senderHash,
        shippingAddressRequired: "false",
        shippingType: "3",
        shippingCost: "0.00",
        creditCardToken: token_card,
        installmentQuantity: qt_parcelas,
        installmentValue: valor_total_parcelado,
        noInterestInstallmentQuantity: "3",
        creditCardHolderName: cartao_nome,
        creditCardHolderCPF: cartao_cpf,
        creditCardHolderBirthDate: cartao_dt_nasc,
        creditCardHolderAreaCode: cartao_ddd,
        creditCardHolderPhone: cartao_phone,
        billingAddressStreet: @cliente.endereco.rua,
        billingAddressNumber: @cliente.endereco.numero,
        billingAddressComplement: @cliente.endereco.complemento,
        billingAddressDistrict: @cliente.endereco.bairro,
        billingAddressPostalCode: @cliente.endereco.cep,
        billingAddressCity: @cliente.endereco.cidade,
        billingAddressState: @cliente.endereco.estado,
        billingAddressCountry: "BRA",
      }
      request = HTTParty.post("https://ws.sandbox.pagseguro.uol.com.br/v2/transactions?email=#{email}&token=#{token_loja}&", {

      })
      debugger
      redirect_to :back
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