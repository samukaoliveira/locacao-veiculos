class CreateVeiculos < ActiveRecord::Migration[7.0]
  def change
    create_table :veiculos do |t|
      t.string :marca
      t.string :cor
      t.string :qnt_passageiros
      t.string :placa

      t.timestamps
    end
  end
end
