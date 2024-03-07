class ReservasController < ClientesController
  before_action :set_reserva, only: %i[ show edit update destroy ]

  # GET /reservas or /reservas.json
  def index
    @reservas = Reserva.all
  end

  # GET /reservas/1 or /reservas/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end

    
    def set_veiculos
      @veiculos = Veiculo.all
    end

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:veiculo_id, :cliente_id, :tempo_espera, :valor_total, :dt_inicial, :dt_final, :pagamento_na_retirada)
    end
end
