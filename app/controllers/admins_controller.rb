class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!
  before_action :marcas_sem_veiculo, only: %i[ initial ] 

  def authenticate_admin!
    if cookies[:admin].blank?
      redirect_to '/login_admin'
    end
  end

  # GET /admins or /admins.json
  def initial
    @reservas = Reserva.all
    @clientes = Cliente.all
    @marcas = Marca.all
    @veiculos = Veiculo.all
  end

  def index
    @admins = Admin.all
  end

  # GET /admins/1 or /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins or /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully created." }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1 or /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1 or /admins/1.json
  def destroy
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url, notice: "Admin was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def cliente
    @cliente = ClienteService.show_cliente(cliente_params)
  end

  def clientes_index
    @clientes = ClienteService.clientes_index
  end

  def reservas
    @reservas = Reserva.all
  end

  def marcas_sem_veiculo
    @marcas_sem = Marca.includes(:veiculos).select { |marca| marca.veiculos.empty? }
    @aviso = "Todas as marcas já tem pelo menos um veículo associado" if @marcas_sem.empty?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:nome, :email, :password)
    end

    def cliente_params
      params.require(:cliente).permit(:nome, :email, :telefone)
    end
end
