class CreateEmprestimos < ActiveRecord::Migration[8.1]
  def change
    create_table :emprestimos do |t|
      t.references :locatario, null: false, foreign_key: true
      t.references :carro, null: false, foreign_key: true
      t.date :data_inicio
      t.date :data_fim
      t.decimal :valor_total

      t.timestamps
    end
  end
end
