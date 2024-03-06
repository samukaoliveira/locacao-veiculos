class AddValorToVeiculos < ActiveRecord::Migration[7.0]
  def change
    add_column :veiculos, :valor, :decimal
  end
end
