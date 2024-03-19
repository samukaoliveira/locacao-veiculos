class AddColumnToReservas < ActiveRecord::Migration[7.0]
  def change
    add_column :reservas, :seguro_extra, :boolean
    add_reference :reservas, :unidade, index: true
  end
end
