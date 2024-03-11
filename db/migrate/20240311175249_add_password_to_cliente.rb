class AddPasswordToCliente < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :password, :string
  end
end
