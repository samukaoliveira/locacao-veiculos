class AlterColumnToVeiculos < ActiveRecord::Migration[7.0]
  def change
    remove_column :veiculos, :qnt_passageiros, :integer
    add_column :veiculos, :qnt_passageiros, :integer
  end
end
