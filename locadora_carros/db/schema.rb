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

ActiveRecord::Schema[8.1].define(version: 2026_06_11_034248) do
  create_table "carros", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "ano"
    t.string "cor"
    t.datetime "created_at", null: false
    t.string "marca"
    t.string "modelo"
    t.string "placa"
    t.datetime "updated_at", null: false
  end

  create_table "emprestimos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "carro_id", null: false
    t.datetime "created_at", null: false
    t.date "data_fim"
    t.date "data_inicio"
    t.bigint "locatario_id", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total", precision: 10
    t.index ["carro_id"], name: "index_emprestimos_on_carro_id"
    t.index ["locatario_id"], name: "index_emprestimos_on_locatario_id"
  end

  create_table "locatarios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.integer "idade"
    t.string "nome"
    t.string "telefone"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "emprestimos", "carros"
  add_foreign_key "emprestimos", "locatarios"
end
