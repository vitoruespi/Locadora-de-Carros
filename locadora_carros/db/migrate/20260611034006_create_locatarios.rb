class CreateLocatarios < ActiveRecord::Migration[8.1]
  def change
    create_table :locatarios do |t|
      t.string :nome
      t.string :cpf
      t.string :telefone
      t.integer :idade

      t.timestamps
    end
  end
end
