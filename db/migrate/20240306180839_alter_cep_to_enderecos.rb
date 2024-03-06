class AlterCepToEnderecos < ActiveRecord::Migration[7.0]
  def change
    remove_column :enderecos, :cep, :integer
    add_column :enderecos, :cep, :string
  end
end
