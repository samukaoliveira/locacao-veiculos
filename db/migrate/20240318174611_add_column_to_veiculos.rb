class AddColumnToVeiculos < ActiveRecord::Migration[7.0]
  def change
    add_column :veiculos, :status, :integer, default: 0
  end
end
