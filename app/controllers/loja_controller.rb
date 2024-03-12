class LojaController < ClientesController
  before_action :set_veiculo, except: :index

  def index
    if params[:nome].present?
      @veiculos = Veiculo.where("lower (nome) ilike '%#{URI::encode_www_form_component(params[:nome])}%'")
    else
      @veiculos = Veiculo.all
    end
  end

  def veiculo

  end







  private

    def set_veiculo
      @veiculo = Veiculo.find(params[:id])
    end


end