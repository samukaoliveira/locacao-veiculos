class CreateReservas < ActiveRecord::Migration[7.0]
  def change
    create_table :reservas do |t|
      t.references :veiculo, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: true
      t.integer :tempo_espera
      t.decimal :valor_total
      t.datetime :dt_inicial
      t.datetime :dt_final
      t.boolean :pagamento_na_retirada

      t.timestamps
    end
  end
end
