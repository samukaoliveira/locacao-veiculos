class CreateVeiculos < ActiveRecord::Migration[7.0]
  def change
    create_table :veiculos do |t|
      t.string :nome
      t.string :cor
      t.string :qnt_passageiros
      t.string :placa
      t.references :marca, null: false, foreign_key: true

      t.timestamps
    end
  end
end
