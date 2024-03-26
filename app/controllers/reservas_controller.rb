class ReservasController < ClientesController
  before_action :set_reserva, only: %i[ show edit update destroy ]
  before_action :set_cliente_cookie
  before_action :recupera_create_failure, only: %i[ create update ]

  # GET /reservas or /reservas.json
  def index
    @reservas = Reserva.all
    @clientes = Cliente.all
  end

  # GET /reservas/1 or /reservas/1.json
  def show
    @pagar = true if @reserva.status == 0
  end

  def new
  end

  # GET /unidades/1/edit
  def edit
  end

  # POST /unidades or /unidades.json
  def create
    @reserva = Reserva.new(reserva_params)
    @reserva.veiculo_id = params[:reserva][:veiculo_id]
    @reserva.cliente_id = @cliente.id
    dt_inicial = Date.strptime(params[:reserva][:dt_inicial], "%d/%m/%Y").strftime("%Y-%m-%d 00:00:00") + " -0300"

    puts "dt_inicial: #{dt_inicial}"
    @pre_reserva = Reserva.where(veiculo_id: @reserva.veiculo_id, dt_inicial: dt_inicial)
    puts "@pre_reserva: #{@pre_reserva.inspect}"
      if @pre_reserva.empty?
          respond_to do |format|
            if @reserva.save
              format.html { redirect_to cliente_reserva_show_path(@cliente, @reserva), notice: "Unidade was successfully created." }
              format.json { render :show, status: :created, location: @reserva }
            else
              format.html { render 'loja/aluguel', status: :unprocessable_entity, notice: @reserva.errors.full_messages.join(', ') }
              format.json { render json: @reserva.errors, status: :unprocessable_entity }
            end
          end
      else
        redirect_to "/loja/aluguel/#{@reserva.veiculo_id}", notice: "Veículo indisponível para esta data. Escolha outra data!"
      end
  end

  # PATCH/PUT /unidades/1 or /unidades/1.json
  def update
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to unidade_url(@reserva), notice: "reserva was successfully updated." }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reserva.destroy

    respond_to do |format|
      format.html { redirect_to reservas_url, notice: "Unidade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    def set_cliente
      @cliente = Cliente.find(params[:cliente_id])
    end

    
    def set_veiculos
      @veiculos = Veiculo.all
    end

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:unidade_id, :veiculo_id, :cliente_id, :tempo_espera, :valor_total, :dt_inicial, :qt_dias, :hr_inicial, :hr_final, :pagamento_na_retirada)
    end

    def set_cliente_cookie
      if cookies[:cliente].present?
        cliente_info = JSON.parse(cookies[:cliente])
        cliente_id = cliente_info['id']
        @cliente = Cliente.find(cliente_id)
      end
    end

    def recupera_create_failure
      @parametros = session[:parametros]
      @unidade_partida = Unidade.find(@parametros.first["partida"].to_i)
      veiculo_info = cookies[:veiculo].gsub(/[{}:]/, "").split("=>")
      veiculo_id = veiculo_info.last.to_i
      @veiculo = Veiculo.find(veiculo_id)
    end
end
