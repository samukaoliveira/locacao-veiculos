class AlterColumnFromReservas < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservas, :dt_final, :datetime
    add_column :reservas, :qt_dias, :integer
  end
end
