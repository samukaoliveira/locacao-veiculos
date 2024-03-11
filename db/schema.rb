# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_11_175249) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.string "password"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "logradouro"
    t.string "complemento"
    t.integer "numero"
    t.string "bairro"
    t.string "cidade"
    t.string "uf"
    t.bigint "cliente_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cep"
    t.index ["cliente_id"], name: "index_enderecos_on_cliente_id"
  end

  create_table "marcas", force: :cascade do |t|
    t.string "nome"
    t.string "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservas", force: :cascade do |t|
    t.bigint "veiculo_id", null: false
    t.bigint "cliente_id", null: false
    t.integer "tempo_espera"
    t.decimal "valor_total"
    t.datetime "dt_inicial"
    t.datetime "dt_final"
    t.boolean "pagamento_na_retirada"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_reservas_on_cliente_id"
    t.index ["veiculo_id"], name: "index_reservas_on_veiculo_id"
  end

  create_table "veiculos", force: :cascade do |t|
    t.string "nome"
    t.string "cor"
    t.string "placa"
    t.bigint "marca_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "qnt_passageiros"
    t.decimal "valor"
    t.index ["marca_id"], name: "index_veiculos_on_marca_id"
  end

  add_foreign_key "enderecos", "clientes"
  add_foreign_key "reservas", "clientes"
  add_foreign_key "reservas", "veiculos"
  add_foreign_key "veiculos", "marcas"
end
