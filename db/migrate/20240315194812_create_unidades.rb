class CreateUnidades < ActiveRecord::Migration[7.0]
  def change
    create_table :unidades do |t|
      t.string :nome
      t.string :rua
      t.string :bairro
      t.string :cidade
      t.string :uf
      t.integer :numero
      t.integer :cep
      t.string :complemento
      t.boolean :status

      t.timestamps
    end
  end
end
