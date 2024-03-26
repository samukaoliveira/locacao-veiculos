class AddColumnToClientes < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :password_hash, :string
  end
end
