class EnderecosController < ApplicationController
  before_action :set_endereco, only: %i[ show edit update destroy ]
  before_action :set_cliente

  # GET /enderecos or /enderecos.json
  def index
    @enderecos = @cliente.enderecos
  end

  # GET /enderecos/1 or /enderecos/1.json
  def show
  end

  # GET /enderecos/new
  def new
    @endereco = Endereco.new
  end

  # GET /enderecos/1/edit
  def edit
  end

  # POST /enderecos or /enderecos.json
  def create
    @endereco = Endereco.new(endereco_params)
    @endereco.cliente_id = @cliente.id

    respond_to do |format|
      if @endereco.save
        format.html { redirect_to cliente_endereco_path(@cliente, @endereco), notice: "Endereco was successfully created." }
        format.json { render :show, status: :created, location: @endereco }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enderecos/1 or /enderecos/1.json
  def update
    @endereco.cliente_id = @cliente.id
    respond_to do |format|
      if @endereco.update(endereco_params)
        format.html { redirect_to endereco_url(@endereco), notice: "Endereco was successfully updated." }
        format.json { render :show, status: :ok, location: @endereco }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @endereco.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enderecos/1 or /enderecos/1.json
  def destroy
    @endereco.destroy

    respond_to do |format|
      format.html { redirect_to enderecos_url, notice: "Endereco was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endereco
      @endereco = Endereco.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endereco_params
      params.require(:endereco).permit(:logradouro, :complemento, :numero, :cep, :bairro, :cidade, :uf, :cliente_id)
    end

    def set_cliente
      @cliente = Cliente.find(params[:cliente_id])
    end
end
