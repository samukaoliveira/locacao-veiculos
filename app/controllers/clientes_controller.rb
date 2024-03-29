class ClientesController < ApplicationController
  layout 'loja'
  before_action :set_cliente, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ show edit update destroy]

  def authenticate_user!
    if cookies[:cliente].blank?
      redirect_to '/login_cliente'
    end
  end

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all
  end

  # GET /clientes/1 or /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = ClienteService.create_cliente(cliente_params)

    respond_to do |format|
      if @cliente.save
        cookies[:cliente] = { id: @cliente.id, nome: @cliente.nome }.to_json
        format.html { redirect_to "/", notice: "Usuário Cadastrado com Sucesso." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if ClienteService.update_cliente(params[:id], cliente_params)
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente was successfully updated." }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    ClienteService.destroy_cliente(params[:id])

    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "Cliente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :email, :cpf, :password, :password_confirmation)
    end
end
