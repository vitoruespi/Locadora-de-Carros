class CreateLocatarios < ActiveRecord::Migration[8.1]
  def change
    create_table :locatarios,id: false do |t|
      t.string :nome
      t.string :cpf, primary_key: true
      t.string :telefone
      t.integer :idade

      t.timestamps
    end
  end
end
