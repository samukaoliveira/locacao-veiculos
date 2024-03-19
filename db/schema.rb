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

ActiveRecord::Schema[7.0].define(version: 2024_03_19_125011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.time "hr_inicial"
    t.time "hr_final"
    t.boolean "seguro_extra"
    t.bigint "unidade_id"
    t.index ["cliente_id"], name: "index_reservas_on_cliente_id"
    t.index ["unidade_id"], name: "index_reservas_on_unidade_id"
    t.index ["veiculo_id"], name: "index_reservas_on_veiculo_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "nome"
    t.string "rua"
    t.string "bairro"
    t.string "cidade"
    t.string "uf"
    t.integer "numero"
    t.integer "cep"
    t.string "complemento"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "ano"
    t.bigint "unidade_id"
    t.integer "status", default: 0
    t.index ["marca_id"], name: "index_veiculos_on_marca_id"
    t.index ["unidade_id"], name: "index_veiculos_on_unidade_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "enderecos", "clientes"
  add_foreign_key "reservas", "clientes"
  add_foreign_key "reservas", "veiculos"
  add_foreign_key "veiculos", "marcas"
end
