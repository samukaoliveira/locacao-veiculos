class AddColumnToReserva < ActiveRecord::Migration[7.0]
  def change
    add_column :reservas, :hr_inicial, :time
    add_column :reservas, :hr_final, :time
  end
end
