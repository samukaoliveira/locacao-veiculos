class CreateEnderecos < ActiveRecord::Migration[7.0]
  def change
    create_table :enderecos do |t|
      t.string :logradouro
      t.string :complemento
      t.integer :numero
      t.integer :cep
      t.string :bairro
      t.string :cidade
      t.string :uf
      t.references :cliente, null: false, foreign_key: true

      t.timestamps
    end
  end
end
