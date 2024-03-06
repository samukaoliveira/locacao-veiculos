class AlterCpfToClientes < ActiveRecord::Migration[7.0]
  def change
    remove_column :clientes, :cpf, :integer
    add_column :clientes, :cpf, :string
  end
end
