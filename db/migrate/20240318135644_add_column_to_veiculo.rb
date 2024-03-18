class AddColumnToVeiculo < ActiveRecord::Migration[7.0]
  def change
    add_reference :veiculos, :unidade, index: true
  end
end
