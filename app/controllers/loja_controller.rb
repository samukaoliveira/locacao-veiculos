class LojaController < ClientesController
  def index
    @veiculos = Veiculo.all
  end
end
