class UnidadesController < ApplicationController
  before_action :set_unidade, only: %i[ show edit update destroy ]

  # GET /unidades or /unidades.json
  def index
    
    id_uni = params[:id_uni]
  
    if id_uni.present?
      @unidades = Unidade.where(id: id_uni)
    else
      @unidades = Unidade.all
    end
  
    if @unidades.empty?
      respond_to do |format|
        format.html # Responde a solicitações HTML
        format.json { render json: { message: "Nenhum resultado encontrado" } }
      end
    else
      respond_to do |format|
        format.html # Responde a solicitações HTML
        format.json { render json: @unidades }
      end
    end
  end

  def unidades_busca
    term = params[:term][:term].to_s.downcase
    @unidades = Unidade.where('LOWER(nome) LIKE :term OR LOWER(bairro) LIKE :term OR LOWER(cidade) LIKE :term',
     term: "%#{term.downcase}%")
    
    respond_to do |format|
      format.json { render json: @unidades.to_json(only: [:id, :nome]) } # Responde a solicitações JSON
    end
    
  end

  # GET /unidades/1 or /unidades/1.json
  def show
  end

  # GET /unidades/new
  def new
    @unidade = Unidade.new
  end

  # GET /unidades/1/edit
  def edit
  end

  # POST /unidades or /unidades.json
  def create
    @unidade = Unidade.new(unidade_params)

    respond_to do |format|
      if @unidade.save
        format.html { redirect_to unidade_url(@unidade), notice: "Unidade was successfully created." }
        format.json { render :show, status: :created, location: @unidade }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @unidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidades/1 or /unidades/1.json
  def update
    respond_to do |format|
      if @unidade.update(unidade_params)
        format.html { redirect_to unidade_url(@unidade), notice: "Unidade was successfully updated." }
        format.json { render :show, status: :ok, location: @unidade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @unidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidades/1 or /unidades/1.json
  def destroy
    @unidade.destroy

    respond_to do |format|
      format.html { redirect_to unidades_url, notice: "Unidade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unidade
      @unidade = Unidade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def unidade_params
      params.require(:unidade).permit(:nome, :rua, :bairro, :cidade, :uf, :numero, :cep, :complemento, :status)
    end
end
